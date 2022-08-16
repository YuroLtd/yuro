import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:yuro/util/src/crc.dart';

void main() {
  test('crc', () {
    const str = '123';
    final data = utf8.encode(str);

    print(data.crc8().toString());
    print(data.crc8().toRadixString(16));

    print(data.crc16().toString());
    print(data.crc16().toRadixString(16));

    print(data.crc24().toString());
    print(data.crc24().toRadixString(16));

    print(data.crc32().toString());
    print(data.crc32().toRadixString(16));

    print(data.crc64().toString());
    print(data.crc64().toRadixString(16));

  });
}
