import 'dart:convert';
import 'package:yuro/yuro_extension/src/string.dart';

import 'level.dart';

/// 日志事件
class LogEvent {
  final LogLevel level;
  final dynamic message;
  final dynamic error;
  final StackTrace? stackTrace;

  LogEvent(this.level, this.message, this.error, this.stackTrace);
}

/// 日志格式化
abstract class LogPrinter {
  List<String> log(String? tag, LogEvent event);

  String stringifyMessage(dynamic message) {
    final finalMessage = message is Function ? message.call() : message;
    if (finalMessage is Map || finalMessage is Iterable) {
      return json.encode(finalMessage);
    } else {
      return finalMessage.toString();
    }
  }
}

/// 简单日志输出
///
/// I/flutter ( 6433): *** Response ***
class SimplePrinter extends LogPrinter {
  final bool printTime;
  final bool printLevel;

  SimplePrinter({this.printTime = false, this.printLevel = true});

  @override
  List<String> log(String? tag, LogEvent event) {
    final timeStr = printTime ? '${DateTime.now().toIso8601String()} ' : '';
    final levelStr = printLevel ? '[${event.level.simpleStr}]' : '';
    final tagStr = tag.isNullOrEmpty() ? '' : '$tag: ';
    final message = stringifyMessage(event.message);
    return ['$timeStr$levelStr$tagStr$message'];
  }
}
