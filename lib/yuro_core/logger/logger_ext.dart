import 'package:yuro/yuro_core/yuro_core.dart';

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
