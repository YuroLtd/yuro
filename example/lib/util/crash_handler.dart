import 'dart:io';

import 'package:example/export.dart';
import 'package:flutter/foundation.dart';
import 'package:yuro_plugin/yuro_plugin.dart';

class CrashHandler {
  static CrashHandler get() {
    if (!Yuro.isRegistered<CrashHandler>()) {
      return Yuro.put(CrashHandler._());
    }
    return Yuro.find<CrashHandler>();
  }

  CrashHandler._();

  Logger get _logger => Logger('CrashHandler');

  late final Isar _isar = Isar.openSync([CrashSchema], name: 'CrashReport');

  void handlerError(FlutterErrorDetails details) {
    _handlerError(details);
  }

  bool handlerPlatFormError(Object object, StackTrace stackTrace) {
    _handlerError(FlutterErrorDetails(exception: object, stack: stackTrace));
    return true;
  }

  void _handlerError(FlutterErrorDetails details) async {
    _logger.e(details);
    // if (kDebugMode) return;
    final error = details.exceptionAsString();
    final stackTrace = details.stack.toString();
    final md5 = '$error:$stackTrace'.toMd5();
    var crash = await _isar.crashs.where().md5EqualTo(md5).build().findFirst();
    final logFile = await YuroPlugin.instance.recordLog();
    final deviceInfo = await YuroPlugin.instance.deviceInfo();
    if (crash == null) {
      crash = Crash.fromDeviceInfo(error, stackTrace, md5, logFile, deviceInfo);
    } else {
      if (crash.logFile.notNull) File(crash.logFile!).deleteIfExists();
      crash = crash.update(logFile, deviceInfo);
    }
    await _isar.writeTxn(() async {
      await _isar.crashs.putByMd5(crash!);
    });
  }

  void report() async {
    final item = await _isar.crashs.filter().uploadedEqualTo(false).findFirst();
    if (item == null) return;
    Observer.fromFuture(Api.system.crashReport(item)).listen(onData: (_) async {
      if (item.logFile.notNull) File(item.logFile!).deleteSync();
      await _isar.writeTxn(() async {
        await _isar.crashs.delete(item.id);
      });
      report();
    });
  }
}
