import 'dart:async';
import 'logger.dart';

abstract class YuroInterface {
  /// 全局日志开关
  bool enableLog = true;

  /// 日志打印过滤等级,默认[info]
  LogLevel logLevel = LogLevel.info;

  /// 根据tag生成[Logger]对象
  Logger tag(String tag) => Logger(tag);

  /// 事件总线
  late final eventBus = StreamController.broadcast();
}

class _YuroImpl extends YuroInterface {}

// ignore: non_constant_identifier_names
final Yuro = _YuroImpl();
