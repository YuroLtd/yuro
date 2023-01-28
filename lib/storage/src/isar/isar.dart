import 'package:isar/isar.dart';
import 'package:yuro/core/core.dart';

export 'package:isar/isar.dart';

extension IsarExt on Isar {
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

extension YuroIsarExt on YuroInterface {
  Isar openIsarSync(
    List<CollectionSchema<dynamic>> schemas, {
    String? directory,
    String name = Isar.defaultName,
    int maxSizeMiB = Isar.defaultMaxSizeMiB,
    bool relaxedDurability = true,
    CompactCondition? compactOnLaunch,
    bool inspector = true,
  }) =>
      Isar.openSync(
        schemas,
        directory: directory,
        name: name,
        maxSizeMiB: maxSizeMiB,
        relaxedDurability: relaxedDurability,
        inspector: inspector,
      );

  Future<Isar> openIsar(
    List<CollectionSchema<dynamic>> schemas, {
    String? directory,
    String name = Isar.defaultName,
    int maxSizeMiB = Isar.defaultMaxSizeMiB,
    bool relaxedDurability = true,
    CompactCondition? compactOnLaunch,
    bool inspector = true,
  }) =>
      Isar.open(
        schemas,
        directory: directory,
        name: name,
        maxSizeMiB: maxSizeMiB,
        relaxedDurability: relaxedDurability,
        inspector: inspector,
      );

  Isar getIsar([String name = Isar.defaultName]) {
    final isar = Isar.getInstance(name);
    if (isar == null) {
      throw IsarError('Instance does not exist. Open an instance of Isar using Yuro.openIsar() or Yuro.openIsarSync()');
    }
    return isar;
  }
}
