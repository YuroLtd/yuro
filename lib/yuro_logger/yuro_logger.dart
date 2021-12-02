library yuro_logger;

import 'package:yuro/yuro_core/yuro_core.dart';

import 'src/config.dart';
import 'src/logger.dart';

export 'src/config.dart';

extension LoggerExt on YuroInterface {
  static late Logger _logger = Logger();

  void updateLogConfig(LogConfig config) => _logger.updateConfig(config);

  Logger get log => _logger;

  void v(dynamic message, [dynamic err, StackTrace? stackTrace]) => log.v(message, err, stackTrace);

  void d(dynamic message, [dynamic err, StackTrace? stackTrace]) => log.d(message, err, stackTrace);

  void i(dynamic message, [dynamic err, StackTrace? stackTrace]) => log.i(message, err, stackTrace);

  void w(dynamic message, [dynamic err, StackTrace? stackTrace]) => log.w(message, err, stackTrace);

  void e(dynamic message, [dynamic err, StackTrace? stackTrace]) => log.e(message, err, stackTrace);
}
