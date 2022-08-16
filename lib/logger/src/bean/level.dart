import 'package:hive_flutter/hive_flutter.dart';

part 'level.g.dart';

@HiveType(typeId: 201)
enum LogLevel {
  //
  @HiveField(1)
  verbose(1, 'VERBOSE', 'V'),
  //
  @HiveField(2)
  info(2, 'INFO', 'I'),
  //
  @HiveField(3)
  debug(3, 'DEBUG', 'D'),
  //
  @HiveField(4)
  warring(4, 'WARRING', 'W'),
  //
  @HiveField(5)
  error(5, 'ERROR', 'E');

  final int level;
  final String str;
  final String short;

  const LogLevel(this.level, this.str, this.short);
}
