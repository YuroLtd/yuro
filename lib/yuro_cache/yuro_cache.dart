library yuro_cache;

import 'dart:async';
import 'dart:io';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yuro/yuro_core/yuro_core.dart';
import 'package:yuro/yuro_util/yuro_util.dart';

export 'package:hive/hive.dart';
export 'package:hive_flutter/hive_flutter.dart';

export 'lru_cache/disk_lru_cache.dart';

extension YuroCacheExt on YuroInterface {
  static late SharedPreferences _sp;
  static late List<int> _hiveKey;

  Future<void> initSharedPreferences() async => _sp = await SharedPreferences.getInstance();

  SharedPreferences get sp => _sp;

  /// * [dir] 存储路径
  Future<void> initHive({String? dir}) async {
    if (dir.isNullOrBlank) {
      final root = await Yuro.temporaryDirectory.then((dir) => dir.parent);
      final dbDir = Directory(root.path.join('hive'));
      if (!dbDir.existsSync()) dbDir.createSync(recursive: true);
      dir = dbDir.path;
    }
    final hiveKey = sp.getString('hiveKey');
    if (hiveKey == null) {
      _hiveKey = Hive.generateSecureKey();
      await sp.setString('hiveKey', _hiveKey.toHex());
    } else {
      _hiveKey = hiveKey.fromHex();
    }
    await Hive.initFlutter(dir);
  }

  Future<Box<T>> openHiveBox<T>([String? boxName]) async => await Hive.openBox<T>(
        boxName ?? T.toString(),
        encryptionCipher: HiveAesCipher(_hiveKey),
      );

  Future<LazyBox<T>> openLazyHiveBox<T>([String? boxName]) async => await Hive.openLazyBox<T>(
        boxName ?? T.toString(),
        encryptionCipher: HiveAesCipher(_hiveKey),
      );

  void registerHiveAdapter<T>(TypeAdapter<T> adapter) => Hive.registerAdapter<T>(adapter);
}

extension HiveExt on HiveInterface {
  Future<void> run<T>(void Function(Box<T> box) run) async {
    final box = await Yuro.openHiveBox<T>();
    await Future(() => run.call(box));
    box.compact();
  }

  Future<void> runLazy<T>(void Function(LazyBox<T> lazyBox) run) async {
    final lazyBox = await Yuro.openLazyHiveBox<T>();
    await Future(() => run.call(lazyBox));
    lazyBox.compact();
  }
}
