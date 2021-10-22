library yuro_logger;

import 'package:flutter/foundation.dart';
import 'package:yuro/yuro_core/yuro_core.dart';
import 'package:yuro/yuro_logger/src/log_filter.dart';
import 'package:yuro/yuro_logger/src/log_level.dart';
import 'package:yuro/yuro_logger/src/log_printer.dart';



class LogConfig {
  late LogFilter logFilter;
  late LogPrinter logPrinter;

  /// [filter] 日志过滤器,默认情况下
  ///
  ///  * 在release模式下打印[LogLevel.info]及以上等级的日志
  ///
  ///  * 在debug模式下打印[LogLevel.verbose]及以上等级的日志
  ///
  LogConfig({LogFilter? filter,LogPrinter? printer}) {
    logFilter = filter ?? (kReleaseMode ? LogFilter.release() : LogFilter.dev());
  }
}

class Logger {
  final LogConfig config;

  Logger(this.config);

  void v(dynamic message, [dynamic err, StackTrace? stackTrace]) {
    _log(LogLevel.verbose, message, err, stackTrace);
  }

  void d(dynamic message, [dynamic err, StackTrace? stackTrace]) {
    _log(LogLevel.debug, message, err, stackTrace);
  }

  void i(dynamic message, [dynamic err, StackTrace? stackTrace]) {
    _log(LogLevel.info, message, err, stackTrace);
  }

  void w(dynamic message, [dynamic err, StackTrace? stackTrace]) {
    _log(LogLevel.warring, message, err, stackTrace);
  }

  void e(dynamic message, [dynamic err, StackTrace? stackTrace]) {
    _log(LogLevel.error, message, err, stackTrace);
  }

  void _log(LogLevel level, dynamic message, [dynamic err, StackTrace? stackTrace]) {
    final event = LogEvent(level, message, err, stackTrace);
    if (!config.logFilter.shouldLog(event)) return;
    final output = config.logPrinter.log(event);

  }
}


extension LoggerExt on YuroInterface {
  static late Logger _logger;

  void initLogger(LogConfig config) => _logger = Logger(config);

  Logger get log => _logger;
}
