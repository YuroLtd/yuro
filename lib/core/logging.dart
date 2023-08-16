import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

import 'interface.dart';

void _loggerRecord(LogRecord record) {
  if (record.level >= Level.SEVERE) {
    FlutterError.dumpErrorToConsole(
        FlutterErrorDetails(
          exception: record.error ?? record.time,
          stack: record.stackTrace,
          library: record.loggerName,
          context: ErrorDescription(record.message),
        ),
        forceReport: true);
    return;
  }

  if (kDebugMode) {
    developer.log(
      record.message,
      time: record.time,
      sequenceNumber: record.sequenceNumber,
      level: record.level.value,
      name: record.loggerName,
      zone: record.zone,
      error: record.error,
      stackTrace: record.stackTrace,
    );
    return;
  }

  // ignore: avoid_print
  print(record);
}

extension LoggerExt on YuroInterface {
  Logger tag(String tag, [Level level = Level.INFO]) => Logger(tag)
    ..level = level
    ..clearListeners()
    ..onRecord.listen(_loggerRecord);
}
