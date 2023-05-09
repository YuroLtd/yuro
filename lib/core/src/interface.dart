import 'dart:async';
import 'logger.dart';

abstract class YuroInterface {
  /// 默认日志
  Logger logger = Logger('Yuro', LogLevel.info);

  /// 根据tag生成[Logger]对象
  Logger tag(String tag, [LogLevel level = LogLevel.info]) => Logger(tag, level);

  /// 事件总线
  late final eventBus = StreamController.broadcast();
}

class _YuroImpl extends YuroInterface {}

// ignore: non_constant_identifier_names
final Yuro = _YuroImpl();
