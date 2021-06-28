import 'interface.dart';

extension LoggerExt on YuroInterface {
  void logV(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    if (Yuro.enableLog) logger.v(message, error, stackTrace);
  }

  void logI(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    if (Yuro.enableLog) logger.i(message, error, stackTrace);
  }

  void logD(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    if (Yuro.enableLog) logger.d(message, error, stackTrace);
  }

  void logW(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    if (Yuro.enableLog) logger.w(message, error, stackTrace);
  }

  void logE(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    if (Yuro.enableLog) logger.e(message, error, stackTrace);
  }
}
