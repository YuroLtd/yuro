import 'package:hive_flutter/hive_flutter.dart';
import 'package:stack_trace/stack_trace.dart';
import 'package:yuro/logger/logger.dart';
import 'package:yuro/util/util.dart';

import 'level.dart';

part 'record.g.dart';

@HiveType(typeId: 200)
class LogRecord {
  @HiveField(0)
  final String tag;

  @HiveField(1)
  final LogLevel level;

  @HiveField(2)
  final String message;

  @HiveField(3)
  final String? extra;

  @HiveField(4)
  final String stack;

  @HiveField(5)
  final int dateTime;

  LogRecord(this.tag, this.level, this.message, this.stack, this.extra, this.dateTime);

  @override
  String toString() => '$tag: $message';
}

extension LogRecordExt on LogRecord {
  StackTrace get stackTrace => StackTrace.fromString(stack);

  String get location => Chain.forTrace(stackTrace)
      .toTrace()
      .frames
      .firstWhere((element) => element.uri.path.baseName != 'logger.dart')
      .location;
}
