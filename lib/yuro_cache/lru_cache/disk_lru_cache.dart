import 'dart:io';

import 'package:synchronized/synchronized.dart';
import 'package:yuro/yuro_core/yuro_core.dart';
import 'package:yuro/yuro_util/yuro_util.dart';

import 'iosink_proxy.dart';
import 'lru_map.dart';

// 日志文件journal的文件格式: 标识 key 文件长度? 超期时间?
//     flutter.io.DiskLruCache
//
//     CLEAN 3400330d1dfc7f3f7f4b8d4d803d3cf6 832 1624005164272
//     DIRTY 3400330d1dfc7f3f7f4b8d4d803d3cf6
//     CLEAN 3400330d1dfc7f3f7f4b8d4d803d3cf6 3934
//     REMOVE 3400330d1dfc7f3f7f4b8d4d803d3cf6
//     DIRTY 3400330d1dfc7f3f7f4b8d4d803d3cf6
//     CLEAN 3400330d1dfc7f3f7f4b8d4d803d3cf6 1600 234
//     READ 3400330d1dfc7f3f7f4b8d4d803d3cf6
//     READ 3400330d1dfc7f3f7f4b8d4d803d3cf6

/// 基于Lru实现的缓存管理
class DiskLruCache {
  static const String MAGIC = 'flutter.io.DiskLruCache';
  static const String JOURNAL_FILE = 'journal';
  static const String JOURNAL_FILE_TEMP = 'journal.tmp';
  static const String JOURNAL_FILE_BACKUP = 'journal.bkp';

  static const String CLEAN = 'CLEAN'; //完成编辑,当前可读
  static const String DIRTY = 'DIRTY'; //进入编辑状态,当前不可读
  static const String REMOVE = 'REMOVE'; //文件已删除,无法读取
  static const String READ = 'READ'; //当前可读

  /// 打开缓存
  ///
  /// @param directory 缓存目录
  ///
  /// @param maxSize   缓存占用空间,单位MB
  static Future<DiskLruCache> open(Directory directory, [int maxSize = 100]) async {
    assert(maxSize > 0, '缓存占用空间必须大于0!');
    File backupFile = File('${directory.path}/$JOURNAL_FILE_BACKUP');
    if (backupFile.existsSync()) {
      File journalFile = File('${directory.path}/$JOURNAL_FILE');
      if (journalFile.existsSync()) {
        backupFile.deleteSync();
      } else {
        backupFile.renameSync(journalFile.path);
      }
    }

    DiskLruCache cache = DiskLruCache._(directory, maxSize);
    if (cache._journalFile.existsSync()) {
      try {
        cache._readJournal();
        cache._processJournal();
        return cache;
      } on IOException catch (e) {
        Yuro.e('DiskLruCache $directory is dirty: ${e.toString()}, remove.');
        cache.clear();
      }
    }
    // 创建缓存目录
    directory.createSync(recursive: true);
    cache._rebuildJournal();
    return cache;
  }

  DiskLruCache._(Directory directory, int maxSize) {
    _directory = directory;
    _journalFile = File('${directory.path}/$JOURNAL_FILE');
    _journalTempFile = File('${directory.path}/$JOURNAL_FILE_TEMP');
    _journalBackupFile = File('${directory.path}/$JOURNAL_FILE_BACKUP');
    _maxSize = maxSize * 1000 * 1000;
    _journalWriter = _journalFile.openWrite(mode: FileMode.append);
  }

  late Directory _directory;
  late File _journalFile;
  late File _journalTempFile;
  late File _journalBackupFile;
  late int _maxSize;
  late IOSink _journalWriter;

  int _size = 0;
  int _redundantOpCount = 0;
  final LruLinkedHashMap<String, Entry> _lruEntries = LruLinkedHashMap();
  final Lock _lock = Lock(reentrant: true);

  /// 读取日志
  void _readJournal() {
    var journal = _journalFile.readAsLinesSync();
    if (journal[0] != MAGIC) throw Exception('日志格式不匹配,读取日志失败.');
    int lineCount = 0;
    for (int i = 3; i < journal.length; i++) {
      _readJournalLine(journal[i]);
      lineCount++;
    }
    _redundantOpCount = lineCount - _lruEntries.length;
    _rebuildJournal();
  }

  /// 解析日志的Entry行
  void _readJournalLine(String line) {
    var items = line.split(' ');
    // 长度在2-4
    // DIRTY REMOVE 标识 key
    // CLEAN READ   标识 key 文件长度 超期时间?
    if (items.length < 2 || items.length > 4) throw Exception('日志格式不匹配,读取日志失败.');
    var tag = items[0];
    var key = items[1];
    if (tag == REMOVE) {
      _lruEntries.remove(key);
      return;
    }
    Entry entry = _lruEntries[key] ?? Entry(key, _directory);
    if (!_lruEntries.containsKey(key)) _lruEntries[key] = entry;
    if (tag == DIRTY) {
      entry.editor = Editor(entry, this);
    } else if (tag == CLEAN || tag == READ) {
      entry
        ..editor = null
        ..length = items[2].toInt()!
        ..expire = items.length == 4 ? items[3].toInt()! : null;
    }
  }

  /// 计算有效缓存大小,清理无效或过期缓存及文件
  void _processJournal() {
    _journalTempFile.deleteIfExists();
    var iterator = _lruEntries.entries.iterator;
    while (iterator.moveNext()) {
      var entry = iterator.current.value;
      if (entry.readable || !entry.isExpire()) {
        _size += entry.length;
      } else {
        // 缓存出现污染,从内存和本地删除
        entry.editor = null;
        entry.getCleanFile().deleteIfExists();
        entry.getDirtyFile().deleteIfExists();
        _lruEntries.remove(entry.key);
      }
    }
  }

  /// 重构日志文件
  void _rebuildJournal() => _lock.synchronized(() {
        _journalTempFile.createSync(recursive: true);
        IOSink ioSink = _journalTempFile.openWrite();
        try {
          ioSink.writeln(MAGIC);
          ioSink.writeln('');
          ioSink.writeln('');

          _lruEntries.values.forEach((e) {
            if (e.editor == null) {
              var expire = e.expire;
              ioSink.writeln('$CLEAN ${e.key} ${e.length}${expire == null ? '' : ' $expire'}');
            } else {
              ioSink.writeln('$DIRTY ${e.key}');
            }
          });
        } finally {
          ioSink.close();
        }

        if (_journalFile.existsSync()) {
          _journalBackupFile.deleteIfExists();
          _journalFile.renameSync(_journalBackupFile.path);
        }
        _journalFile.deleteIfExists();
        _journalTempFile.renameSync(_journalFile.path);
      });

  /// 增加冗余计数器,根据需要重构日志文件
  void _addRedundantOpCount() => _lock.synchronized(() {
        _redundantOpCount++;
        if (_redundantOpCount >= 2000 || _redundantOpCount >= _lruEntries.length) {
          Yuro.i('redundantOpCount: $_redundantOpCount, cacheEntry count: ${_lruEntries.length}, 开始重构缓存日志文件');
          _rebuildJournal();
        }
      });

  /// 缓存空间不足时,释放空间
  void _trimToSize() {
    // 将keys做反序迭代
    var iterator = _lruEntries.keys.toList().reversed.iterator;
    while (_size >= _maxSize && iterator.moveNext()) {
      remove(iterator.current);
    }
  }

  Future _editCommit(Entry entry, bool success) => _lock.synchronized(() async {
        var dirtyFile = entry.getDirtyFile();
        var cleanFile = entry.getCleanFile();

        int oldLength = entry.length;
        entry.length = await dirtyFile.length();

        _size += entry.length - oldLength;
        _trimToSize();
        cleanFile.deleteIfExists();
        dirtyFile.renameSync(cleanFile.path);
        var expire = entry.expire;
        _journalWriter.writeln('$CLEAN ${entry.key} ${entry.length}${expire == null ? '' : ' $expire'}');
        _addRedundantOpCount();
      });

  /// 获取缓存大小
  int getSize() => _size;

  /// 获取缓存快照
  Future<Snapshot?> get(String key) => _lock.synchronized<Snapshot?>(() async {
        Entry? entry = _lruEntries[key];
        if (entry == null) {
          Yuro.i('cache key: $key 不存在.');
          return null;
        }
        if (!entry.readable) {
          Yuro.i('cache key: $key 正在编辑中,无法读取.');
          return null;
        }
        if (entry.isExpire()) {
          Yuro.i('cache key: $key 已过期,将从内存和本地移除.');
          remove(key);
          return null;
        }
        var expire = entry.expire;
        _journalWriter.writeln('$READ $key ${entry.length}${expire == null ? '' : ' $expire'}');
        await _journalWriter.flush();
        _addRedundantOpCount();
        return Snapshot(entry, this);
      });

  /// 编辑缓存
  Future<Editor> edit(String key, [Duration? expire]) => _lock.synchronized<Editor>(() async {
        Entry entry = _lruEntries[key] ??= Entry(key, _directory);
        if (expire != null) {
          entry.expire = Yuro.currentTimeStamp + expire.inMilliseconds;
        }
        if (entry.editor == null) {
          entry.editor = Editor(entry, this);
          _journalWriter.writeln('$DIRTY ${entry.key}');
          await _journalWriter.flush();
          _addRedundantOpCount();
        }
        return entry.editor!;
      });

  /// 移除缓存
  Future<bool> remove(String key) => _lock.synchronized<bool>(() async {
        Entry? entry = _lruEntries[key];
        if (entry == null) {
          Yuro.d('key: "$key"不存在,移除失败.');
          return false;
        }
        if (!entry.readable) {
          Yuro.d('key: "$key"正在编辑中,无法移除.');
          return false;
        }
        entry.getCleanFile().deleteIfExists();
        _size -= entry.length;
        _journalWriter.writeln('$REMOVE $key');
        await _journalWriter.flush();
        _lruEntries.remove(key);
        _addRedundantOpCount();
        return true;
      });

  /// 清空缓存
  Future<void> clear() => _lock.synchronized<void>(() {
        _directory.deleteSync(recursive: true);
        _lruEntries.clear();
        _size = 0;
        _redundantOpCount = 0;
        _rebuildJournal();
      });
}

class Snapshot {
  Snapshot(this.entry, this._cache);

  final Entry entry;
  final DiskLruCache _cache;

  Future<Editor?> getEditor() => _cache.edit(entry.key);

  String getString() => entry.getCleanFile().readAsStringSync();

  Stream<List<int>> getStream() => entry.getCleanFile().openRead();
}

class Editor {
  Editor(this.entry, this._cache) {
    File dirtyFile = entry.getDirtyFile();
    if (!dirtyFile.existsSync()) dirtyFile.createSync();
    _ioSink = IOSinkProxy(entry.getDirtyFile().openWrite(), _onErr);
  }

  final Entry entry;
  final DiskLruCache _cache;

  late IOSink _ioSink;

  ///
  void write(Object value) => _ioSink.write(value);

  void writeStream(Stream<List<int>> value) => value.listen(
        (data) => _ioSink.add(data),
        onError: (e) => _ioSink.addError(e),
        onDone: () => _ioSink.close(),
      );

  ///
  Future<void> commit() async {
    await _ioSink.flush();
    await _cache._editCommit(entry, true);
  }

  ///
  Future<void> abort() => _cache._editCommit(entry, false);

  void _onErr(e) async {
    Yuro.e('写缓存失败: $e');
    entry.getDirtyFile().deleteIfExists();
    entry.editor = null;
    await abort();
  }
}

class Entry {
  Entry(this.key, this.directory);

  // 缓存Key
  final String key;

  // 缓存目录
  final Directory directory;

  // 缓存文件长度
  int length = 0;

  // 缓存编辑器
  Editor? editor;

  // 文件超期毫秒值
  int? expire;

  // 是否可读
  bool get readable => editor == null;

  // 缓存是否过期
  bool isExpire() => DateTime.now().millisecondsSinceEpoch >= (expire ?? double.infinity.toInt());

  File getCleanFile() => File('${directory.path}/$key');

  File getDirtyFile() => File('${directory.path}/$key.tmp');
}
