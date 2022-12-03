// ignore_for_file: avoid_print

import 'package:flutter_test/flutter_test.dart';
import 'package:yuro/util/util.dart';

void main() {
  test('FileSizeExt test', () {
    expect(1.B.formatFileSize(), '1B');
    expect(1.KB.formatFileSize(), '1.00KB');
    expect(1.MB.formatFileSize(), '1.00MB');
    expect(1.GB.formatFileSize(), '1.00GB');
    expect(1.TB.formatFileSize(), '1.00TB');
  });

  test('fast hash', () {
    print(' '.fastHash());
    print('1'.fastHash());
  });
}
