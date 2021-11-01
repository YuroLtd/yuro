import 'num.dart';
import 'datetime.dart';
import 'util/datetime_format.dart';

extension StringExt on String {
  int? toInt() => int.tryParse(this);

  bool isDigit() => int.tryParse(this) != null;

  double? toDouble() => double.tryParse(this);

  /// 判断字符串是否是手机号
  bool isPhone() => RegExp(r'^1(3|4|5|6|7|8|9)\d{9}$').hasMatch(this);

  DateTime? parseToDateTime() => DateTime.tryParse(this);

  String formatMilliSeconds([String format = DateTimeFormats.DEFAULT]) {
    try {
      return int.parse(this).parseToDateTime().format(format);
    } on FormatException catch (_) {
      return '';
    }
  }
}

extension NullableStringExt on String? {
  bool isNullOrEmpty() => this == null || this!.isEmpty;

  bool isNullOrBlank() => this == null || this!.trim().isEmpty;
}
