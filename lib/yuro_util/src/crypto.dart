import 'dart:convert';

import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';

extension CryptoExt on String {
  String toMd5([String salt = '']) => hex.encode(md5.convert(utf8.encode('${this}$salt')).bytes);

  String toSha1() => hex.encode(sha1.convert(utf8.encode(this)).bytes);

  String toSha256() => hex.encode(sha256.convert(utf8.encode(this)).bytes);

  String toSha512() => hex.encode(sha512.convert(utf8.encode(this)).bytes);

  String toBase64() => base64Encode(utf8.encode(this));

  String fromBase64() => utf8.decode(base64Decode(this));

  List<int> fromHex() => hex.decode(this);

  Map<String,dynamic> fromJsonStr()=> json.decode(this);
}

extension ListIntExt on List<int> {
  String toHex() => hex.encode(this);
}

extension ObjectExt on Object {
  String toJsonStr() => json.encode(this);
}
