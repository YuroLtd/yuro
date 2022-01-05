import 'dart:io';

import 'package:yuro/objectbox.g.dart';
import 'package:yuro/yuro_core/yuro_core.dart';
import 'package:yuro/yuro_util/src/path.dart';

import 'entity/crashlytics.dart';

export 'entity/crashlytics.dart';

class AnalysisDatabase {
  static late final Store _store;

  static Future<void> init() async {
    final root = await Yuro.temporaryDirectory.then((dir) => dir.parent);
    final dbDir = Directory(root.path.join('databases/analysis/'));
    if (!dbDir.existsSync()) dbDir.createSync(recursive: true);
    _store = await openStore(directory: dbDir.path);
  }

  static AnalysisDatabase? _instance;

  static AnalysisDatabase get instance => _instance ??= AnalysisDatabase._();

  AnalysisDatabase._();

  Box<Crashlytics> get _crashlyticsBox => _store.box<Crashlytics>();

  /// 插入或更新一条崩溃日志
  void putCrashlytics(Crashlytics crashlytics) {
    final item = _crashlyticsBox.query(Crashlytics_.signature.equals(crashlytics.signature)).build().findFirst();
    if (item != null) {
      item
        ..count += crashlytics.count
        ..updateTime = DateTime.now();
      _crashlyticsBox.put(item);
      Yuro.tag('Crashlytics').i('crashlytics was updated.');
    } else {
      _crashlyticsBox.put(crashlytics);
      Yuro.tag('Crashlytics').i('crashlytics was recorded.');
    }
  }

  /// 批量删除崩溃日志
  void batchDeleteCrashlytics(List<int> ids) => _crashlyticsBox.removeMany(ids);

  /// 查询所有崩溃日志
  List<Crashlytics> notUploadCrashlytics() => _crashlyticsBox.getAll();
}
