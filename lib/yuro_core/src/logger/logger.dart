import '../interface.dart';

import 'config.dart';
import 'output.dart';
import 'level.dart';
import 'printer.dart';

export 'config.dart';

extension LoggerExt on YuroInterface {
  static LogConfig _config = LogConfig();

  set logConfig(LogConfig config) => _config = config;

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
    if (!_config.enable) return;

    final logEvent = LogEvent(level, message, err, stackTrace);
    // 判断是否需要打印该日志
    if (!_config.filter.shouldLog(logEvent)) return;
    final lines = _config.printer.log(logEvent);
    if (lines.isNotEmpty) {
      final outputEvent = OutputEvent(level, lines);
      _config.output.output(outputEvent);
    }
  }
}
