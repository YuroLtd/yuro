import 'package:collection/collection.dart';

extension ListExt<T> on List<T> {
  List<T> reverse() => reversed.toList();
}

extension NullableListExt<T> on List<T>? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  bool get notNullOrEmpty => !isNullOrEmpty;

  List<T>? merge(List<T>? other) {
    if (other.notNullOrEmpty) {
      return List.of(this ?? [])..addAll(other!);
    }
    return this;
  }
}

extension MapExt<K, V> on Map<K, V> {
  bool equals(Map<K, V> other) => const DeepCollectionEquality().equals(this, other);

  Map<K, V> where(bool Function(K key, V value) test) {
    final list = <MapEntry<K, V>>[];
    for (final element in entries) {
      if (test(element.key, element.value)) list.add(element);
    }
    return Map.fromEntries(list);
  }

  String sign() {
    final sb = StringBuffer();
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


extension NullableMapExt<K, V> on Map<K, V>? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  bool get notNullOrEmpty => !isNullOrEmpty;
}