import 'package:yuro/yuro_extension/src/util/num_to_rmb.dart';

extension NumExt on num {
  /// 格式化距离
  String formatDistance() {
    final distance = this.round();
    if (distance < 1000) {
      return '${distance}m';
    } else {
      return '${(distance / 1000).toStringAsFixed(1)}km';
    }
  }

  /// 格式化金额
  String formatMoney([String? unit]) => '${this.toStringAsFixed(2)}${unit ?? ''}';

  /// 格式化为大写人民币
  String formatToRMB([int fixed = 2]) {
    assert(fixed >= 0 && fixed <= 3);
    return NumToRMB().toChinese(this.toStringAsFixed(fixed));
  }
}

extension IntExt on int {
  DateTime parseToDateTime([bool isUtc = false]) => DateTime.fromMillisecondsSinceEpoch(this, isUtc: isUtc);
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

/// [int]的最大值 2^53
const int int_infinity = 0x20000000000001;

/// [int]的最小值 -2^53
const int int_negativeInfinity = 0x20000000000001;
