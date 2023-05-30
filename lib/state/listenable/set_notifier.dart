import 'dart:collection';

import 'package:flutter/foundation.dart';

class SetNotifier<T> extends ValueNotifier<Set<T>> with SetMixin<T> {
  factory SetNotifier.from(Set<T> other) => SetNotifier(Set.from(other));

  factory SetNotifier.of(Set<T> other) => SetNotifier(Set.of(other));

  factory SetNotifier.unmodifiable(Set<T> other) => SetNotifier(Set.unmodifiable(other));

  factory SetNotifier.identity() => SetNotifier(Set.identity());

  SetNotifier([super.value = const {}]);

  @override
  bool add(T value) {
    final result = super.value.add(value);
    if (result) notifyListeners();
    return result;
  }

  @override
  bool contains(Object? element) => value.contains(element);

  @override
  Iterator<T> get iterator => value.iterator;

  @override
  int get length => value.length;

  @override
  T? lookup(Object? element) => value.lookup(element);

  @override
  bool remove(Object? value) {
    final result = super.value.remove(value);
    if (result) notifyListeners();
    return result;
  }

  @override
  Set<T> toSet() => value.toSet();
}

extension SetNotifierExt<T> on Set<T> {
  SetNotifier<T> get obs => SetNotifier<T>(this);
}
