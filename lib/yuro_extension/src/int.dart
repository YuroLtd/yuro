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
