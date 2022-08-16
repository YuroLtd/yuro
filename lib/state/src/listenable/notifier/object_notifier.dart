part of '../value_notifier.dart';

class ObjectNotifier<T> extends ValueNotifier<T> {
  ObjectNotifier(T value) : _value = value;

  T _value;

  @override
  T get value {
    reportRead();
    return _value;
  }

  set value(T newValue) {
    if (_value == newValue) return;
    _value = newValue;
    refresh();
  }
}

extension ObjectNotifierExt<T> on T {
  ObjectNotifier<T> get obs => ObjectNotifier<T>(this);
}
