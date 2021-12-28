import 'util/money_for_zh.dart';

extension NumExt on num {
  /// 格式化距离
  String formatDistance() {
    final distance = round();
    if (distance < 1000) {
      return '${distance}m';
    } else {
      return '${(distance / 1000).toStringAsFixed(1)}km';
    }
  }

  /// 格式化金额
  String formatMoney([String? unit]) => '${toStringAsFixed(2)}${unit ?? ''}';

  /// 格式化为大写人民币
  String formatToRMB([int fixed = 2]) {
    assert(fixed >= 0 && fixed <= 3);
    return MoneyForZh().toChinese(toStringAsFixed(fixed));
  }
}

extension DurationForIntExt on int {
  Duration get day => Duration(days: this);

  Duration get hour => Duration(hours: this);

  Duration get minute => Duration(minutes: this);

  Duration get second => Duration(seconds: this);

  Duration get millisecond => Duration(milliseconds: this);
}

extension FileSizeForIntExt on int {
  String formatFileSize() {
    if (this < 1000) {
      return '${this}B';
    } else if (this < 1000 * 1000) {
      var temp = this / 1000;
      return '${temp.toStringAsFixed(2)}KB';
    } else if (this < 1000 * 1000 * 1000) {
      var temp = this / 1000 / 1000;
      return '${temp.toStringAsFixed(2)}MB';
    } else {
      var temp = this / 1000 / 1000 / 1000;
      return '${temp.toStringAsFixed(2)}GB';
    }
  }

  int get B => this;

  // ignore: non_constant_identifier_names
  int get KB => this * 1000;

  // ignore: non_constant_identifier_names
  int get MB => this * 1000 * 1000;

  // ignore: non_constant_identifier_names
  int get GB => this * 1000 * 1000 * 1000;
}