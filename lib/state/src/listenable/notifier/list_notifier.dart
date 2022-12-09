import 'dart:collection';

import 'object_notifier.dart';

class ListNotifier<T> extends ObjectNotifier<List<T>> with ListMixin<T> {
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

  ListNotifier([List<T> list = const []]) : super(list);

  @override
  int get length => value.length;

  @override
  T operator [](int index) => value[index];

  @override
  void operator []=(int index, T value) {
    super.value[index] = value;
    refresh();
  }

  @override
  set length(int newLength) {
    value.length = newLength;
    refresh();
  }

  @override
  void add(T element) {
    value.add(element);
     refresh();
  }

  @override
  void clear() {
    length = 0;
  }
}

extension ListNotifierExt<T> on List<T> {
  ListNotifier<T> get obs => ListNotifier<T>(this);
}
