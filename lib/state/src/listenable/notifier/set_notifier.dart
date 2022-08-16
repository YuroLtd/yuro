part of '../value_notifier.dart';

class SetNotifier<T> extends ValueNotifier<Set<T>> with SetMixin<T> {
  factory SetNotifier.from(Set<T> other) => SetNotifier(Set.from(other));

  factory SetNotifier.of(Set<T> other) => SetNotifier(Set.of(other));

  factory SetNotifier.unmodifiable(Set<T> other) => SetNotifier(Set.unmodifiable(other));

  factory SetNotifier.identity() => SetNotifier(Set.identity());

  SetNotifier([Set<T> set = const {}]) : _value = set;

  // ignore: prefer_final_fields
  Set<T> _value;

  @override
  Set<T> get value {
    reportRead();
    return _value;
  }

  set value(Set<T> other) {
    if (_value.equals(other)) return;
    _value = other;
    refresh();
  }

  @override
  bool add(T value) {
    final result = _value.add(value);
    if (result) refresh();
    return result;
  }

  @override
  bool contains(Object? element) => _value.contains(element);

  @override
  Iterator<T> get iterator => _value.iterator;

  @override
  int get length => _value.length;

  @override
  T? lookup(Object? element) => _value.lookup(element);

  @override
  bool remove(Object? value) {
    final result = _value.remove(value);
    if (result) refresh();
    return result;
  }

  @override
  Set<T> toSet() => _value.toSet();
}

extension SetNotifierExt<T> on Set<T> {
  SetNotifier<T> get obs => SetNotifier<T>(this);
}
