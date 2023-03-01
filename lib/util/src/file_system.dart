import 'dart:io';

extension FileSystemEntityExt on FileSystemEntity {
  void deleteIfExists([bool recursive = false]) {
    if (existsSync()) deleteSync(recursive: recursive);
  }
}

extension FileExt on File {
  void createIfNotExists([bool recursive = false]) {
    if (!existsSync()) createSync(recursive: recursive);
  }
}

extension DirectoryExt on Directory {
  void createIfNotExists([bool recursive = false]) {
    if (!existsSync()) createSync(recursive: recursive);
  }
}
