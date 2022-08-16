part of '../value_notifier.dart';

class ListNotifier<T> extends ValueNotifier<List<T>> with ListMixin<T> {
  factory ListNotifier.filled(int length, T fill, {bool growable = false}) {
    return ListNotifier(List.filled(length, fill, growable: growable));
  }

  factory ListNotifier.empty({bool growable = false}) {
    return ListNotifier(List.empty(growable: growable));
  }

  factory ListNotifier.from(Iterable elements, {bool growable = true}) {
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

  ListNotifier([List<T> list = const []]) : _value = list;

  List<T> _value;

  @override
  List<T> get value {
    reportRead();
    return _value;
  }

  set value(List<T> other) {
    if (_value.equals(other)) return;
    _value = other;
    refresh();
  }

  @override
  int get length => _value.length;

  @override
  set length(int newLength) {
    _value.length = newLength;
    refresh();
  }

  @override
  T operator [](int index) => _value[index];

  @override
  void operator []=(int index, T value) {
    _value[index] = value;
    refresh();
  }
}

extension ListNotifierExt<T> on List<T> {
  ListNotifier<T> get obs => ListNotifier<T>(this);
}
