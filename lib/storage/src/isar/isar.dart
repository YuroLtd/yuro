import 'package:isar/isar.dart';

export 'package:isar/isar.dart';

extension IsarExt on Isar {
  Isar getIsar([String name = Isar.defaultName]) {
    final isar = Isar.getInstance(name);
    if (isar == null) {
      throw IsarError('Instance does not exist. Open an instance of Isar using Isar.open() or Isar.openSync()');
    }
    return isar;
  }

  Future<T> writeIsar<T>(Future<T> Function(Isar isar) callback, {bool silent = false}) async {
    return await writeTxn(() => callback.call(this), silent: false);
  }

  T writeIsarSync<T>(T Function(Isar isar) callback, {bool silent = false}) {
    return writeTxnSync(() => callback.call(this), silent: false);
  }

  Future<T> readIsar<T>(Future<T> Function(Isar isar) callback) async {
    return await txn(() => callback.call(this));
  }

  T readIsarSync<T>(T Function(Isar isar) callback) {
    return txnSync(() => callback.call(this));
  }
}
