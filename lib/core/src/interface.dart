import 'dart:async';

import 'package:flutter/foundation.dart';

import 'logger.dart';

abstract class YuroInterface {
  // 默认日志
  late final logger = Logger('Yuro');

  /// 全局日志开关
  bool enableLogger = kDebugMode;

  /// 日志打印过滤等级,默认[info]
  LogLevel logLevel = LogLevel.info;

  // 事件总线
  late final eventBus = StreamController.broadcast();
}

class _YuroImpl extends YuroInterface {}

// ignore: non_constant_identifier_names
final Yuro = _YuroImpl();
