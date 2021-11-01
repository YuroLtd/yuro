import 'package:yuro/yuro_core/yuro_core.dart';

import 'util/datetime_format.dart';

extension DateTimeForYuroExt on YuroInterface {
  DateTime get currentDateTime => DateTime.now();

  int get currentMilliSeconds => currentDateTime.millisecondsSinceEpoch;
}

extension DateTimeExt on DateTime {
  String format([String format = DateTimeFormats.DEFAULT]) => DateTimeFormats().format(this, format);

  int get daysInMonth => DateTime(year, month + 1, 1).difference(DateTime(year, month, 1)).inDays;

  Duration intervalNow() => difference(Yuro.currentDateTime);
}
