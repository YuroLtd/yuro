import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class YuroCrashlytics {
  static YuroCrashlytics? _instance;

  static YuroCrashlytics get instance => _instance ?? YuroCrashlytics._();

  YuroCrashlytics._();

  // 上报日志
  // 在debug模式下,直接打印到控制台
  // 在release模式下,将Error发送到Zone统一处理
  void reportError(FlutterErrorDetails details) {
    if (kReleaseMode) {
      Zone.current.handleUncaughtError(details.exception, details.stack ?? StackTrace.current);
    } else {
      FlutterError.dumpErrorToConsole(details);
    }
  }
}
