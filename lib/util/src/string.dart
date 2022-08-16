import 'package:path/path.dart' as path;

extension StringExt on String {
  int? toInt() => int.tryParse(this);

  bool isDigit() => int.tryParse(this) != null;

  double? toDouble() => double.tryParse(this);
}

extension PathExt on String {
  String join(String dir) => path.join(this, dir);

  String get baseName => path.basename(this);

  String get basenameWithoutExtension => path.basenameWithoutExtension(this);

  String get dirname => path.dirname(this);

  String extension([int level = 1]) => path.extension(this, level);

  String get withoutExtension => path.withoutExtension(this);

  String setExtension(String extension) => path.setExtension(this, extension);
}

extension NullStringExt on String? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  bool get isNullOrBlank => this == null || this!.trim().isEmpty;
}
