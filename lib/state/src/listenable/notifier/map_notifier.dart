import 'dart:collection';

import 'object_notifier.dart';

class MapNotifier<K, V> extends ObjectNotifier<Map<K, V>> with MapMixin<K, V> {
  factory MapNotifier.fromMap(Map<K, V> other) => MapNotifier(Map.from(other));

  factory MapNotifier.of(Map<K, V> other) => MapNotifier(Map.of(other));

  factory MapNotifier.unmodifiable(Map<K, V> other) => MapNotifier(Map.unmodifiable(other));

  factory MapNotifier.identity() => MapNotifier(Map.identity());

  MapNotifier([Map<K, V> map = const {}]) : super(map);

  @override
  V? operator [](Object? key) => value[key];

  @override
  void operator []=(K key, V value) {
    super.value[key] = value;
    refresh();
  }

  @override
  void clear() {
    value.clear();
    refresh();
  }

  @override
  Iterable<K> get keys => value.keys;

  @override
  V? remove(Object? key) {
    final result = value.remove(key);
    refresh();
    return result;
  }
}

extension MapNotifierExt<K, V> on Map<K, V> {
  MapNotifier<K, V> get obs => MapNotifier<K, V>(this);
}
