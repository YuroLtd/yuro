import 'package:flutter/foundation.dart';

import 'filter.dart';
import 'output.dart';
import 'printer.dart';

class LogConfig {
  final bool enable;
  late final LogFilter filter;
  late final LogPrinter printer;
  late final LogOutput output;

  /// [filter] 日志过滤器,默认情况下
  ///  * [enable]是否启用日志打印,默认为true
  ///
  ///  * [filter]打印级别过滤,默认在release模式下打印[LogLevel.info]及以上等级的日志,
  ///  在debug模式下打印[LogLevel.verbose]及以上等级的日志
  LogConfig({
    this.enable = true,
    LogFilter? logFilter,
    LogPrinter? logPrinter,
    LogOutput? logOutput,
  }) {
    filter = logFilter ?? (kReleaseMode ? LogFilter.release() : LogFilter.dev());
    printer = logPrinter ?? SimplePrinter();
    output = logOutput ?? ConsoleOutput();
  }
}
