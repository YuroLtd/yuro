import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

abstract class YuroInterface {
  Logger logger = Logger();
  bool enableLog = kDebugMode;
}

class _YuroImpl extends YuroInterface {}

// ignore: non_constant_identifier_names
final Yuro = _YuroImpl();
