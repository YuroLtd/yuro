import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:yuro/state/obs.dart';

class MapNotifier<K, V> extends ValueNotifier<Map<K, V>> with MapMixin<K, V>, ValueNotifierMixin {
  factory MapNotifier.fromMap(Map<K, V> other) => MapNotifier(Map.from(other));

  factory MapNotifier.of(Map<K, V> other) => MapNotifier(Map.of(other));

  factory MapNotifier.unmodifiable(Map<K, V> other) => MapNotifier(Map.unmodifiable(other));

  factory MapNotifier.identity() => MapNotifier(Map.identity());

  MapNotifier([super.value = const {}]);

  @override
  V? operator [](Object? key) => value[key];

  @override
  void operator []=(K key, V value) {
    super.value[key] = value;
    notifyListeners();
  }

  @override
  void clear() {
    value.clear();
    notifyListeners();
  }

  @override
  Iterable<K> get keys => value.keys;

  @override
  V? remove(Object? key) {
    final result = value.remove(key);
    notifyListeners();
    return result;
  }
}

extension MapNotifierExt<K, V> on Map<K, V> {
  MapNotifier<K, V> get obs => MapNotifier<K, V>(this);
}
