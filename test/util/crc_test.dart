import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yuro/util/src/crc.dart';

void main() {
  test('crc', () {
    const str = '123';
    final data = utf8.encode(str);

    debugPrint(data.crc8().toString());
    debugPrint(data.crc8().toRadixString(16));

    debugPrint(data.crc16().toString());
    debugPrint(data.crc16().toRadixString(16));

    debugPrint(data.crc24().toString());
    debugPrint(data.crc24().toRadixString(16));

    debugPrint(data.crc32().toString());
    debugPrint(data.crc32().toRadixString(16));

    debugPrint(data.crc64().toString());
    debugPrint(data.crc64().toRadixString(16));

  });
}
