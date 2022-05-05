import 'package:yuro/yuro_core/yuro_core.dart';

import 'datetime_format.dart';

extension DateTimeForYuroExt on YuroInterface {
  DateTime get currentDateTime => DateTime.now();

  int get currentTimeStamp => currentDateTime.millisecondsSinceEpoch;
}

extension DateTimeForIntExt on int {
  DateTime parseToDateTime([bool isUtc = false]) => DateTime.fromMillisecondsSinceEpoch(this, isUtc: isUtc);
}

extension DateTimeForStringExt on String {
  DateTime? parseToDateTime() => DateTime.tryParse(this);

  String? formatMilliSeconds([String format = DateFormats.DEFAULT]) {
    return int.tryParse(this)?.parseToDateTime().format(format);
  }
}

extension DateTimeExt on DateTime {
  String format([String format = DateFormats.DEFAULT]) => DateFormats().format(this, format);

  int get dayInMonth => DateTime(year, month + 1, 1).difference(DateTime(year, month, 1)).inDays;

  Duration intervalNow() => difference(Yuro.currentDateTime);

  DateTime get firstDay => DateTime(year, month, 1);

  DateTime get lastDay => DateTime(year, month + 1, 1).subtract(const Duration(days: 1));
}
