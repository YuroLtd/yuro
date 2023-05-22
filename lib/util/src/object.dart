import 'dart:convert';

extension ObjectOperatorExt<T extends Object> on T {
  R let<R>(R Function(T it) action) => action.call(this);
}

extension ObjectExt on Object? {
  String toJsonStr({Object? Function(dynamic object)? toEncodable}) => json.encode(this, toEncodable: toEncodable);
}
