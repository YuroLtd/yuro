import 'dart:convert';

import 'package:yuro/yuro_logger/src/log_level.dart';

class LogEvent {
  final LogLevel level;
  final dynamic message;
  final dynamic error;
  final StackTrace? stackTrace;

  LogEvent(this.level, this.message, this.error, this.stackTrace);
}

abstract class LogPrinter {
  List<String> log(LogEvent event);
}

class SimplePrinter extends LogPrinter {
  final bool printTime;
  final bool printLevel;

  SimplePrinter({this.printTime = false, this.printLevel = false});

  @override
  List<String> log(LogEvent event) {
    final timeStr = printTime ? DateTime.now().toIso8601String() : '';
    final levelStr = printLevel ? ' [${event.level.simpleStr}] ' : '';
    final message = _stringifyMessage(event.message);
    return ['$timeStr$levelStr$message'];
  }

  String _stringifyMessage(dynamic message) {
    final finalMessage = message is Function ? message.call() : message;
    if (finalMessage is Map || finalMessage is Iterable) {
      return json.encode(finalMessage);
    } else {
      return finalMessage.toString();
    }
  }
}
