import 'dart:io';

extension FileExt on File {
  void deleteIfExists({bool recursive = false}) {
    if (existsSync()) deleteSync(recursive: recursive);
  }

  void createIfNotExists({bool recursive = false}) {
    if (!existsSync()) createSync(recursive: recursive);
  }
}
