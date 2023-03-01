import 'package:yuro/util/util.dart';

extension MapExt<K, V> on Map<K, V> {
  void put(K key, V value) => this[key] = value;

  bool equals(Map<K, V> other) => const DeepCollectionEquality().equals(this, other);

  Map<K, V> where(bool Function(K key, V value) test) {
    final list = <MapEntry<K, V>>[];
    for (final element in entries) {
      if (test(element.key, element.value)) list.add(element);
    }
    return Map.fromEntries(list);
  }

  String signStr() {
    var sb = StringBuffer();
    forEach((key, value) {
      sb
        ..write(key)
        ..write('=')
        ..write(value)
        ..write('&');
    });
    return sb.toString().substring(0, sb.length - 1);
  }
}

extension NullMapExt<K, V> on Map<K, V>? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  bool get notNullOrEmpty => !isNullOrEmpty;

  Map<K, V>? merge(Map<K, V>? other) {
    if (other.notNullOrEmpty) {
      return Map<K, V>.of(this ?? {})..addAll(other!);
    }
    return this;
  }
}
