import 'dart:async';

import 'package:convert/convert.dart' show hex;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:yuro/core/core.dart';

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

  Future<Box<T>> openHiveBox<T>([String? boxName]) => Hive.openBox<T>(
        boxName ?? T.toString(),
        encryptionCipher: HiveAesCipher(_hiveKey),
      );

  Future<LazyBox<T>> openHiveLazyBox<T>([String? boxName]) => Hive.openLazyBox<T>(
        boxName ?? T.toString(),
        encryptionCipher: HiveAesCipher(_hiveKey),
      );

  Future<void> hive<T>(void Function(Box<T> box) run, [String? boxName]) async {
    final completer = Completer();
    Yuro.openHiveBox<T>(boxName).then((box){
      run.call(box);
      completer.complete();
    });
    return completer.future;
  }

  Future<void> lazyHive<T>(void Function(LazyBox<T> lazyBox) run,[String? boxName]) async {
    final completer = Completer();
    Yuro.openHiveLazyBox<T>(boxName).then((lazyBox){
      run.call(lazyBox);
      completer.complete();
    });
    return completer.future;
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
