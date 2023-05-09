import 'dart:convert';
import 'package:yuro/core/core.dart';

enum LogLevel {
  off(0, ''),
  //
  verbose(1, 'V'),
  //
  info(2, 'I'),
  //
  debug(3, 'D'),
  //
  warring(4, 'W'),
  //
  error(5, 'E');

  final int code;
  final String short;

  const LogLevel(this.code, this.short);
}

class LogInfo {
  final String tag;

  final LogLevel level;

  final dynamic message;

  final dynamic extra;

  LogInfo(this.tag, this.level, this.message, this.extra);

  String _stringify(dynamic content) {
    final finalMessage = message is Function ? message.call() : message;
    if (finalMessage is String) {
      return finalMessage;
    } else if (finalMessage is Map || finalMessage is Iterable) {
      return json.encode(finalMessage);
    } else {
      return finalMessage.toString();
    }
  }

  List<String> format() {
    final list = <String>[];
    final messages = _stringify(message).split('\n');
    list.addAll(messages.map((e) => '[${level.short}]$tag: $e').toList());
    if (extra != null) {
      final extras = _stringify(extra).split('\n');
      list.add('[${level.short}]$tag: extras');
      list.addAll(extras.map((e) => '[${level.short}]$tag: $e').toList());
    }
    return list;
  }
}

class Logger {
  static final _loggers = <String, Logger>{};

  factory Logger(String tag, LogLevel level) => _loggers.putIfAbsent(tag, () => Logger._(tag, level));

  final String tag;

  final LogLevel level;

  Logger._(this.tag, this.level);

  void v(dynamic message, [dynamic extra]) => _log(LogLevel.verbose, message, extra);

  void i(dynamic message, [dynamic extra]) => _log(LogLevel.info, message, extra);

  void d(dynamic message, [dynamic extra]) => _log(LogLevel.debug, message, extra);

  void w(dynamic message, [dynamic extra]) => _log(LogLevel.warring, message, extra);

  void e(dynamic message, [dynamic extra]) => _log(LogLevel.error, message, extra);

  void _log(LogLevel logLevel, dynamic message, dynamic extra) {
    final record = LogInfo(tag, logLevel, message, extra);
    // ignore: avoid_print
    if (logLevel.code >= level.code) record.format().forEach(print);
  }
}

extension LoggerExt on YuroInterface {
  void v(dynamic message, [dynamic extra]) => Yuro.logger.v(message, extra);

  void i(dynamic message, [dynamic extra]) => Yuro.logger.i(message, extra);

  void d(dynamic message, [dynamic extra]) => Yuro.logger.d(message, extra);

  void w(dynamic message, [dynamic extra]) => Yuro.logger.w(message, extra);

  void e(dynamic message, [dynamic extra]) => Yuro.logger.e(message, extra);
}
