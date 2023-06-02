import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:yuro/state/obs.dart';

class ListNotifier<T> extends ValueNotifier<List<T>> with ListMixin<T>, ValueNotifierMixin {
  factory ListNotifier.filled(int length, T fill, {bool growable = false}) {
    return ListNotifier(List.filled(length, fill, growable: growable));
  }

  factory ListNotifier.empty({bool growable = false}) {
    return ListNotifier(List.empty(growable: growable));
  }

  factory ListNotifier.from(Iterable<T> elements, {bool growable = true}) {
    return ListNotifier(List.from(elements, growable: growable));
  }

  factory ListNotifier.of(Iterable<T> elements, {bool growable = true}) {
    return ListNotifier(List.of(elements, growable: growable));
  }

  factory ListNotifier.generate(int length, T Function(int index) generator, {bool growable = true}) {
    return ListNotifier(List.generate(length, generator, growable: growable));
  }

  factory ListNotifier.unmodifiable(Iterable elements) {
    return ListNotifier(List.unmodifiable(elements));
  }

  ListNotifier([super.value = const []]);

  @override
  int get length => value.length;

  @override
  T operator [](int index) => value[index];

  @override
  void operator []=(int index, T value) {
    super.value[index] = value;
    notifyListeners();
  }

  @override
  set length(int newLength) {
    value.length = newLength;
    notifyListeners();
  }

  @override
  void add(T element) {
    value.add(element);
    notifyListeners();
  }

  @override
  void clear() {
    length = 0;
  }
}

extension ListNotifierExt<T> on List<T> {
  ListNotifier<T> get obs => ListNotifier<T>(this);
}
