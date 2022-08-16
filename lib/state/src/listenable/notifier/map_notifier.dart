part of '../value_notifier.dart';

class MapNotifier<K, V> extends ValueNotifier<Map<K, V>> with MapMixin<K, V> {
  factory MapNotifier.fromMap(Map<K, V> other) => MapNotifier(Map.from(other));

  factory MapNotifier.of(Map<K, V> other) => MapNotifier(Map.of(other));

  factory MapNotifier.unmodifiable(Map<K, V> other) => MapNotifier(Map.unmodifiable(other));

  factory MapNotifier.identity() => MapNotifier(Map.identity());

  MapNotifier([Map<K, V> map = const {}]) : _value = map;

  // ignore: prefer_final_fields
  Map<K, V> _value;

  @override
  Map<K, V> get value {
    reportRead();
    return _value;
  }

  set value(Map<K, V> other) {
    if (_value.equals(other)) return;
    _value = other;
    refresh();
  }

  @override
  V? operator [](Object? key) => _value[key];

  @override
  void operator []=(K key, V value) {
    _value[key] = value;
    refresh();
  }

  @override
  void clear() {
    _value.clear();
    refresh();
  }

  @override
  Iterable<K> get keys => _value.keys;

  @override
  V? remove(Object? key) {
    final result = _value.remove(key);
    // 不能确保泛型V是否允许为null,所以每次调用都要刷新
    refresh();
    return result;
  }
}

extension MapNotifierExt<K, V> on Map<K, V> {
  MapNotifier<K, V> get obs => MapNotifier<K, V>(this);
}
