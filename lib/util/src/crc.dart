import 'dart:convert';

import 'package:crclib/catalog.dart';
import 'package:crclib/crclib.dart';

export 'package:crclib/catalog.dart';

extension CrcValueExt on CrcValue {
  List<int> toBytes() => utf8.encode(toString());
}

extension CRCLib on List<int> {
  CrcValue crc8() => Crc8().convert(this);

  CrcValue crc16() => Crc16().convert(this);

  CrcValue crc24() => Crc24().convert(this);

  CrcValue crc32() => Crc32().convert(this);

  CrcValue crc64() => Crc64().convert(this);
}
