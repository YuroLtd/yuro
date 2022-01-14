import 'dart:io';

import 'package:yuro/yuro_util/yuro_util.dart';
import 'package:hive_flutter/hive_flutter.dart';

export 'package:hive/hive.dart';
export 'package:hive_flutter/hive_flutter.dart';

import '../interface.dart';
import 'shared_preferences.dart';

extension YuroHiveExt on YuroInterface {
  static late List<int> _hiveKey;

  /// * [dir] 存储路径
  Future<void> initHive({String? dir}) async {
    if (dir.isNullOrBlank) {
      final root = await Yuro.temporaryDirectory.then((dir) => dir.parent);
      final dbDir = Directory(root.path.join('hive'));
      if (!dbDir.existsSync()) dbDir.createSync(recursive: true);
      dir = dbDir.path;
    }
    final hiveKey = Yuro.sp.getString('hiveKey');
    if (hiveKey == null) {
      _hiveKey = Hive.generateSecureKey();
      await Yuro.sp.setString('hiveKey', _hiveKey.toHex());
    } else {
      _hiveKey = hiveKey.fromHex();
    }
    await Hive.initFlutter(dir);
  }

  Future<Box<T>> openHiveBox<T>([String? boxName]) async =>
      await Hive.openBox<T>(boxName ?? T.toString(), encryptionCipher: HiveAesCipher(_hiveKey));

  Future<LazyBox<T>> openHiveLazyBox<T>([String? boxName]) async =>
      await Hive.openLazyBox<T>(boxName ?? T.toString(), encryptionCipher: HiveAesCipher(_hiveKey));

  Box<T> hiveBox<T>([String? boxName]) => Hive.box<T>(boxName ?? T.toString());

  LazyBox<T> hiveLazyBox<T>([String? boxName]) => Hive.lazyBox<T>(boxName ?? T.toString());

  void registerHiveAdapter<T>(TypeAdapter<T> adapter) => Hive.registerAdapter<T>(adapter);

  bool isHiveAdapterRegistered<T>(int typeId) => Hive.isAdapterRegistered(typeId);

  Future<void> hive<T>(void Function(Box<T> box) run) async {
    final box = await Yuro.openHiveBox<T>();
    await Future(() => run.call(box));
    box.compact();
  }

  Future<void> lazyHive<T>(void Function(LazyBox<T> lazyBox) run) async {
    final lazyBox = await Yuro.openHiveLazyBox<T>();
    await Future(() => run.call(lazyBox));
    lazyBox.compact();
  }
}
