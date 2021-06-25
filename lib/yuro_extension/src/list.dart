import 'dart:typed_data';

import 'package:convert/convert.dart';

extension Uint8ListExt on Uint8List {
  String toHex() => hex.encode(this.toList());
}
