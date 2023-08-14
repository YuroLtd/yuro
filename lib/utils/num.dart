// ignore_for_file: non_constant_identifier_names

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

  String format({int fixed = 2, String prefix = '', String suffix = ''}) => '$prefix${toStringAsFixed(fixed)}$suffix';
}

extension DurationExt on int {
  Duration get day => Duration(days: this);

  Duration get hour => Duration(hours: this);

  Duration get minute => Duration(minutes: this);

  Duration get second => Duration(seconds: this);

  Duration get millisecond => Duration(milliseconds: this);
}

extension FileSizeExt on int {
  String formatFileSize() {
    if (this < 1.KB) {
      return '${this}B';
    } else if (this < 1.MB) {
      return '${(this / 1.KB).toStringAsFixed(2)}KB';
    } else if (this < 1.GB) {
      return '${(this / 1.MB).toStringAsFixed(2)}MB';
    } else if (this < 1.TB) {
      return '${(this / 1.GB).toStringAsFixed(2)}GB';
    } else {
      return '${(this / 1.TB).toStringAsFixed(2)}TB';
    }
  }

  int get B => this;

  int get KB => this * 1024.B;

  int get MB => this * 1024.KB;

  int get GB => this * 1024.MB;

  int get TB => this * 1024.GB;
}
