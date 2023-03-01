import 'dart:convert';

import 'package:yuro/core/core.dart';

enum LogLevel {
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

  final int level;
  final String short;

  const LogLevel(this.level, this.short);
}

class LogInfo {
  final String tag;

  final LogLevel level;

  late final List<String> messages;

  final String? extra;

  LogInfo(this.tag, this.level, String message, this.extra) : messages = message.split('\n');

  @override
  String toString() => '$tag[${level.short}]: ${messages.join('\n')}';

  List<String> format() => messages.map((e) => '$tag[${level.short}]: $e').toList();
}

class Logger {
  static final _loggers = <String, Logger>{};

  factory Logger(String tag) => _loggers.putIfAbsent(tag, () => Logger._(tag));

  final String tag;

  Logger._(this.tag);

  bool _enable = true;

  set enable(bool value) => _enable = value;

  void v(dynamic message, {dynamic extra}) => log(LogLevel.verbose, message, extra: extra);

  void i(dynamic message, {dynamic extra}) => log(LogLevel.info, message, extra: extra);

  void d(dynamic message, {dynamic extra}) => log(LogLevel.debug, message, extra: extra);

  void w(dynamic message, {dynamic extra}) => log(LogLevel.warring, message, extra: extra);

  void e(dynamic message, {dynamic extra}) => log(LogLevel.error, message, extra: extra);

  String _stringifyMessage(dynamic message) {
    final finalMessage = message is Function ? message.call() : message;
    if (finalMessage is Map || finalMessage is Iterable) {
      return json.encode(finalMessage);
    } else {
      return finalMessage.toString();
    }
  }

  void log(LogLevel logLevel, dynamic message, {dynamic extra}) async {
    final finalMsg = _stringifyMessage(message);
    final finalExtra = _stringifyMessage(extra);
    final record = LogInfo(tag, logLevel, finalMsg, finalExtra);
    if (Yuro.enableLog && _enable && logLevel.level >= Yuro.logLevel.level) {
      // ignore: avoid_print
      record.format().forEach(print);
    }
  }
}
