import 'dart:convert';
import 'dart:developer' as developer;

import 'package:stack_trace/stack_trace.dart';
import 'package:yuro/util/util.dart';

import 'interface.dart';

enum LogLevel {
  //
  verbose(1, 'VERBOSE', 'V'),
  //
  info(2, 'INFO', 'I'),
  //
  debug(3, 'DEBUG', 'D'),
  //
  warring(4, 'WARRING', 'W'),
  //
  error(5, 'ERROR', 'E');

  final int level;
  final String str;
  final String short;

  const LogLevel(this.level, this.str, this.short);
}

class _LogInfo {
  final String tag;

  final LogLevel level;

  final String message;

  final String? extra;

  final String stack;

  final int dateTime;

  _LogInfo(this.tag, this.level, this.message, this.stack, this.extra, this.dateTime);

  @override
  String toString() => '$tag[$location]: $message';

  StackTrace get stackTrace => StackTrace.fromString(stack);

  String get location => Chain.forTrace(stackTrace)
      .toTrace()
      .frames
      .firstWhere((element) => element.uri.path.baseName != 'logger.dart')
      .location;
}

class Logger {
  static final _loggers = <String, Logger>{};

  factory Logger(String tag) => _loggers.putIfAbsent(tag, () => Logger._(tag));

  final String tag;

  Logger._(this.tag);

  bool _enable = true;

  set enable(bool value) => _enable = value;

  void v(dynamic message, {dynamic extra}) => log(LogLevel.verbose, message, extra: extra);

  void d(dynamic message, {dynamic extra}) => log(LogLevel.debug, message, extra: extra);

  void i(dynamic message, {dynamic extra}) => log(LogLevel.info, message, extra: extra);

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
    final stackTrace = StackTrace.current;
    final record = _LogInfo(tag, logLevel, finalMsg, stackTrace.toString(), finalExtra, Yuro.currentTimeStamp);
    if (Yuro.enableLogger && _enable && logLevel.level >= Yuro.logLevel.level) {
      developer.log(record.toString(), name: logLevel.short, level: logLevel.level);
    }
  }
}

extension LoggerExt on YuroInterface {
  Logger tag(String tag) => Logger(tag);

  void v(dynamic message, {dynamic extra}) => logger.v(message, extra: extra);

  void d(dynamic message, {dynamic extra}) => logger.d(message, extra: extra);

  void i(dynamic message, {dynamic extra}) => logger.i(message, extra: extra);

  void w(dynamic message, {dynamic extra}) => logger.w(message, extra: extra);

  void e(dynamic message, {dynamic extra}) => logger.e(message, extra: extra);
}
