import 'dart:async';
import 'dart:io';

import 'package:convert/convert.dart' show hex;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:yuro/core/core.dart';
import 'package:yuro/util/util.dart';

import 'shared_preferences.dart';

export 'package:hive_flutter/hive_flutter.dart';

extension HiveExt on YuroInterface {
  List<int> get _hiveKey {
    final hiveKey = Yuro.sp.getString('hiveKey');
    if (hiveKey != null) return hex.decode(hiveKey);
    //
    final newKey = Hive.generateSecureKey();
    Yuro.sp.setString('hiveKey', hex.encode(newKey));
    return newKey;
  }

  Future<void> initHive({String? dir}) async {
    if (dir.isNullOrBlank) {
      final root = await Yuro.temporaryDirectory.then((dir) => dir.parent);
      final hiveDir = Directory(root.path.join('hive'))..createIfNotExists(true);
      dir = hiveDir.path;
    }
    await Hive.initFlutter(dir);
  }

  void registerHiveAdapter<T>(TypeAdapter<T> adapter) => Hive.registerAdapter<T>(adapter);

  bool isHiveAdapterRegistered<T>(int typeId) => Hive.isAdapterRegistered(typeId);

  Future<Box<T>> openHiveBox<T>([String? boxName]) => Hive.openBox<T>(
        boxName ?? T.toString(),
        encryptionCipher: HiveAesCipher(_hiveKey),
      );

  Future<LazyBox<T>> openHiveLazyBox<T>([String? boxName]) => Hive.openLazyBox<T>(
        boxName ?? T.toString(),
        encryptionCipher: HiveAesCipher(_hiveKey),
      );

  Future<void> hive<T>(void Function(Box<T> box) run, [String? boxName]) async {
    final box = await Yuro.openHiveBox<T>(boxName);
    await Future(() => run.call(box));
  }

  Future<void> lazyHive<T>(void Function(LazyBox<T> lazyBox) run,[String? boxName]) async {
    final lazyBox = await Yuro.openHiveLazyBox<T>(boxName);
    await Future(() => run.call(lazyBox));
  }

  Future<List<T>> hiveQuery<T>(bool Function(T element) test) async {
    final completer = Completer<List<T>>();
    Yuro.openHiveBox<T>().then((box) {
      final list = box.values.where(test).toList();
      completer.complete(list);
    });
    return completer.future;
  }
}
