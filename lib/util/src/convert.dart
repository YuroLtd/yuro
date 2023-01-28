import 'dart:convert';

import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();

String get uuid1 => _uuid.v1();

String get uuid4 => _uuid.v4();

extension CryptoExt on String {
  String uuid5([String namespace = Uuid.NAMESPACE_URL]) => _uuid.v5(namespace, this);

  String toMd5([String salt = '']) => hex.encode(md5.convert(utf8.encode('$this$salt')).bytes);

  String toSha1() => hex.encode(sha1.convert(utf8.encode(this)).bytes);

  String toSha256() => hex.encode(sha256.convert(utf8.encode(this)).bytes);

  String toSha512() => hex.encode(sha512.convert(utf8.encode(this)).bytes);

  String toBase64() => base64Encode(utf8.encode(this));

  String fromBase64() => utf8.decode(base64Decode(this));

  List<int> fromHex() => hex.decode(this);

  dynamic fromJsonStr({Object? Function(Object? key, Object? value)? reviver}) => json.decode(this, reviver: reviver);

  List<int> toBytes() => utf8.encode(this);
}

extension ListIntExt on List<int> {
  String toHex() => hex.encode(this);

  String base64() => base64Encode(this);

  String toStr() => utf8.decode(this);
}

extension ObjectExt on Object? {
  bool get isNull => this == null;

  bool get notNull => this != null;

  String toJsonStr({Object? Function(dynamic object)? toEncodable}) => json.encode(this, toEncodable: toEncodable);
}
