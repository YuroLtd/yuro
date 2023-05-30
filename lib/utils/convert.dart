import 'dart:convert';

import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:uuid/uuid.dart';

extension ConvertExt on String {
  String toBase64() => base64Encode(utf8.encode(this));

  String fromBase64() => utf8.decode(base64Decode(this));

  List<int> fromHex() => hex.decode(this);

  dynamic fromJsonStr({Object? Function(Object? key, Object? value)? reviver}) => json.decode(this, reviver: reviver);

  List<int> toBytes() => utf8.encode(this);
}

extension UuidExt on String {
  String uuid5([String namespace = Uuid.NAMESPACE_URL]) => const Uuid().v5(namespace, this);
}

extension CryptoExt on String {
  String toMd5([String salt = '']) => hex.encode(md5.convert(utf8.encode('$this$salt')).bytes);

  String toSha1() => hex.encode(sha1.convert(utf8.encode(this)).bytes);

  String toSha256() => hex.encode(sha256.convert(utf8.encode(this)).bytes);

  String toSha512() => hex.encode(sha512.convert(utf8.encode(this)).bytes);
}

extension ListIntExt on List<int> {
  String toHex() => hex.encode(this);

  String base64() => base64Encode(this);

  String decode({bool? allowMalformed}) => utf8.decode(this, allowMalformed: allowMalformed);
}
