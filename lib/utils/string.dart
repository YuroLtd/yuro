import 'package:path/path.dart' as path;

extension StringExt on String {
  int? toInt({int? radix}) => int.tryParse(this, radix: radix);

  bool isDigit() => int.tryParse(this) != null;

  double? toDouble() => double.tryParse(this);

  bool get isBlank => trim().isEmpty;
}

extension PathExt on String {
  String join(String dir, [String? part2, String? part3, String? part4, String? part5, String? part6, String? part7]) =>
      path.join(this, dir, part2, part3, part4, part5, part6, part7);

  String get baseName => path.basename(this);

  String get basenameWithoutExtension => path.basenameWithoutExtension(this);

  String get dirname => path.dirname(this);

  String extension([int level = 1]) => path.extension(this, level);

  String get withoutExtension => path.withoutExtension(this);

  String setExtension(String extension) => path.setExtension(this, extension);
}

extension NullStringExt on String? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  bool get notNullOrEmpty => !isNullOrEmpty;

  bool get isNullOrBlank => this == null || this!.trim().isEmpty;

  bool get notNullOrBlank => !isNullOrBlank;
}
