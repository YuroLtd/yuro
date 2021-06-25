import 'dart:convert';

import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:uuid/uuid.dart';

extension CryptoExt on String {
  String uuid5() => Uuid().v5(Uuid.NAMESPACE_OID, this);

  String toMd5([String salt = '']) => hex.encode(md5.convert(utf8.encode('${this}$salt')).bytes);

  String toSha1() => hex.encode(sha1.convert(utf8.encode(this)).bytes);

  String toSha256() => hex.encode(sha256.convert(utf8.encode(this)).bytes);

  String toSha512() => hex.encode(sha512.convert(utf8.encode(this)).bytes);

  String toBase64() => base64Encode(utf8.encode(this));

  String fromBase64() => utf8.decode(base64Decode(this));

  List<int> toUint8List() => hex.decode(this);
}
