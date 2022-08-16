import 'dart:convert';
import 'dart:developer' as developer;

import 'package:hive_flutter/hive_flutter.dart';
import 'package:yuro/core/core.dart';
import 'package:yuro/storage/storage.dart';
import 'package:yuro/util/util.dart';

import 'bean/level.dart';
import 'bean/record.dart';

class Logger {
  static final _loggers = <String, Logger>{};
  static Box<LogRecord>? _recordBox;

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

  void _record(LogRecord record) async {
    // web没有hive
    if (Yuro.isWeb) return;
    _recordBox ??= await Yuro.openHiveBox<LogRecord>();
    _recordBox!.add(record);
  }

  void log(LogLevel logLevel, dynamic message, {dynamic extra}) async {
    final finalMsg = _stringifyMessage(message);
    final finalExtra = _stringifyMessage(extra);
    final stackTrace = StackTrace.current;
    final record = LogRecord(tag, logLevel, finalMsg, stackTrace.toString(), finalExtra, Yuro.currentTimeStamp);
     _record(record);
    if (Yuro.logEnable && _enable && logLevel.level >= Yuro.logLevel.level) {
      developer.log(record.toString(), name: logLevel.short, level: logLevel.level);
    }
  }
}
