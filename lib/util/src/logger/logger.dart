import 'dart:convert';
import 'dart:developer' as developer;

import 'package:isar/isar.dart';
import 'package:yuro/core/core.dart';
import 'package:yuro/util/util.dart';

part 'logger.g.dart';

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

@collection
class LogInfo {
  Id id = Isar.autoIncrement;

  final String tag;

  @enumerated
  final LogLevel level;

  final String message;

  final String? extra;

  final String stack;

  final int dateTime;

  LogInfo(this.tag, this.level, this.message, this.stack, this.extra, this.dateTime);

  @override
  String toString() => '$tag: $message';
}

class Logger {
  static final _loggers = <String, Logger>{};

  static Isar? _isar;

  static final _lock = Lock();

  static Future<Isar> _getIsar() async => await _lock.synchronized(() async {
        _isar ??= await Isar.open([LogInfoSchema]);
        return _isar!;
      });

  static void _record(LogInfo info) async => await _getIsar().then((isar) => isar.writeTxn(() async {
        await isar.logInfos.put(info);
      }));

  /// 导出[startTime]开始的日志, 如果未null则导出全部日志
  static Future<List<LogInfo>> export({int? startTime}) async => await _getIsar().then((isar) => isar.txn(() async {
        return await isar.logInfos.filter().dateTimeGreaterThan(startTime ?? 0).findAll();
      }));

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
    final record = LogInfo(tag, logLevel, finalMsg, stackTrace.toString(), finalExtra, Yuro.currentTimeStamp);
    if (!Yuro.isWeb) _record(record);
    if (Yuro.enableLog && _enable && logLevel.level >= Yuro.logLevel.level) {
      developer.log(record.toString(), name: logLevel.short, level: logLevel.level);
    }
  }
}
