import 'package:yuro/yuro_logger/src/log_level.dart';
import 'package:yuro/yuro_logger/src/log_printer.dart';

/// 日志过滤器,如果传入日志等级大于等于当前过滤器等级则打印,否则忽略
class LogFilter {
  final LogLevel level;

  LogFilter(this.level);

  factory LogFilter.dev() => LogFilter(LogLevel.verbose);

  factory LogFilter.release() => LogFilter(LogLevel.info);

  bool shouldLog(LogEvent event) => event.level.index >= level.index;
}
