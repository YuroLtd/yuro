import '../interface.dart';

import 'config.dart';
import 'output.dart';
import 'level.dart';
import 'printer.dart';

export 'config.dart';
export 'output.dart';
export 'printer.dart';
export 'level.dart';

extension LoggerExt on YuroInterface {
  static Logger _logger = Logger(LogConfig.DEFAULT);

  void changeLogConfig(LogConfig config) => _logger = Logger(config);

  void v(dynamic message, [dynamic err, StackTrace? stackTrace]) => tag().v(message, err, stackTrace);

  void d(dynamic message, [dynamic err, StackTrace? stackTrace]) => tag().d(message, err, stackTrace);

  void i(dynamic message, [dynamic err, StackTrace? stackTrace]) => tag().i(message, err, stackTrace);

  void w(dynamic message, [dynamic err, StackTrace? stackTrace]) => tag().w(message, err, stackTrace);

  void e(dynamic message, [dynamic err, StackTrace? stackTrace]) => tag().e(message, err, stackTrace);

  Logger tag([String? tag]) => _logger.setTag(tag);
}

class Logger {
  final LogConfig config;

  Logger(this.config);

  String? _tag;

  Logger setTag(String? tag) {
    _tag = tag;
    return this;
  }

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
    // 如果日志打印未开启,则返回
    if (!config.enable) return;

    final logEvent = LogEvent(level, message, err, stackTrace);
    // 判断是否需要打印该日志
    if (!config.filter.shouldLog(logEvent)) return;
    final lines = config.printer.log(_tag, logEvent);
    if (lines.isNotEmpty) {
      final outputEvent = OutputEvent(level, lines);
      config.output.output(outputEvent);
    }
  }
}