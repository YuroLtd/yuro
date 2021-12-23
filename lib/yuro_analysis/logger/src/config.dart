import 'package:flutter/foundation.dart';

import 'filter.dart';
import 'output.dart';
import 'printer.dart';

class LogConfig {
  final bool enable;
  final LogFilter filter;
  final LogPrinter printer;
  final LogOutput output;

  /// [filter] 日志过滤器,默认情况下
  ///  * [enable]是否启用日志打印,默认为true
  ///
  ///  * [filter]打印级别过滤,默认在release模式下打印[LogLevel.info]及以上等级的日志,
  ///  在debug模式下打印[LogLevel.verbose]及以上等级的日志
  LogConfig({
    this.enable = true,
    required this.filter,
    required this.printer,
    required this.output,
  });

  // ignore: non_constant_identifier_names
  static LogConfig get DEFAULT => LogConfig(
        enable: true,
        filter: kReleaseMode ? LogFilter.release() : LogFilter.dev(),
        printer: SimplePrinter(),
        output: ConsoleOutput(),
      );
}
