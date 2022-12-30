import 'package:path/path.dart' as path;

extension StringExt on String {
  int? toInt({int? radix}) => int.tryParse(this, radix: radix);

  bool isDigit() => int.tryParse(this) != null;

  double? toDouble() => double.tryParse(this);

  bool get isBlank => trim().isEmpty;

  String fastHash() {
    var hash = 0xcbf29ce484222325;
    var i = 0;
    while (i < length) {
      final codeUnit = codeUnitAt(i++);
      hash ^= codeUnit >> 8;
      hash *= 0x100000001b3;
      hash ^= codeUnit & 0xFF;
      hash *= 0x100000001b3;
    }
    return hash.toRadixString(16);
  }
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
  bool get isNull => this == null;

  bool get noNull => this != null;

  bool get isNullOrEmpty => this == null || this!.isEmpty;

  bool get isNullOrBlank => this == null || this!.trim().isEmpty;
}
