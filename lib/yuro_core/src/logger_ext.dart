import 'package:logger/logger.dart';

import 'interface.dart';

extension LoggerExt on YuroInterface {
  static late Logger _log;

  void initLogger(LogConfig config) {
    _log = Logger(filter: config.filter, printer: config.printer, output: config.output, level: config.level);
  }

  Logger get log => _log;
}

class LogConfig {
  LogFilter? filter;
  LogPrinter? printer;
  LogOutput? output;
  Level? level;

  LogConfig({this.filter, this.printer, this.output, this.level});
}
