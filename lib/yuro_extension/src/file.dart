import 'dart:io';

extension FileExt on File {
  void deleteIfExists({bool recursive = false}) {
    if (existsSync()) deleteSync(recursive: recursive);
  }
}
