// ignore_for_file: constant_identifier_names

import 'package:intl/intl.dart';
import 'package:yuro/core/interface.dart';

extension DateTimeForYuroExt on YuroInterface {
  DateTime get currentDateTime => DateTime.now();

  int get currentTimeStamp => currentDateTime.millisecondsSinceEpoch;
}

extension DateTimeForIntExt on int {
  DateTime toDateTime([bool isUtc = false]) => DateTime.fromMillisecondsSinceEpoch(this, isUtc: isUtc);
}

extension DateTimeForStringExt on String {
  DateTime? toDateTime([DateFormat? df, bool utc = false]) {
    try {
      return df == null ? DateTime.tryParse(this) : df.parse(this, utc);
    } catch (e) {
      return null;
    }
  }
}

sealed class DateFormats {
  static DateFormat date() => DateFormat('yyyy-MM-dd');
  static DateFormat time() => DateFormat('HH:mm:ss');
  static DateFormat datetime() => DateFormat('yyyy-MM-dd HH:mm:ss');
}

extension DateTimeExt on DateTime {
  String format([DateFormat? df]) => (df ?? DateFormats.datetime()).format(this);

  Duration intervalToNow() => difference(Yuro.currentDateTime);

  /// 本月天数
  int get monthDays => DateTime(year, month + 1, 1).difference(DateTime(year, month, 1)).inDays;

  /// 本月第一天
  DateTime get monthFirstDay => DateTime(year, month, 1);

  /// 本月最后一天
  DateTime get monthLastDay => DateTime(year, month + 1, 1).subtract(const Duration(days: 1));

  String get weekDayZh {
    const zh = ['星期一', '星期二', '星期三', '星期四', '星期五', '星期六', '星期日'];
    return zh[weekday - 1];
  }

  DateTime get max => DateTime(year, month, day, 23, 59, 59);

  DateTime get min => DateTime(year, month, day);

  DateTime get date => DateTime(year, month, day);
}
