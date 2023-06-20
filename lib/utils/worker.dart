import 'dart:async';

import 'package:flutter/material.dart';
import 'package:yuro/utils/num.dart';

enum WorkerType { every, once, interval }

class Worker<T> extends ValueNotifier<T?> {
  factory Worker.every(ValueSetter<T?> callback, {T? initValue, bool Function(T? value)? condition}) =>
      Worker._(initValue, type: WorkerType.every, callback: callback, condition: condition);

  factory Worker.once(ValueSetter<T?> callback, {T? initValue, bool Function(T? value)? condition}) =>
      Worker._(initValue, type: WorkerType.once, callback: callback, condition: condition);

  factory Worker.interval(ValueSetter<T?> callback, {T? initValue, bool Function(T? value)? condition, Duration? duration}) =>
      Worker._(initValue, type: WorkerType.interval, callback: callback, condition: condition);

  Worker._(super.value, {required this.type, required this.callback, this.condition, this.duration});

  final WorkerType type;
  final ValueSetter<T?> callback;
  final bool Function(T? value)? condition;
  final Duration? duration;

  bool _sendOnce = false;
  Timer? _timer;

  @override
  void notifyListeners() {
    super.notifyListeners();
    switch (type) {
      case WorkerType.every:
        if (condition?.call(value) ?? true) callback.call(value);
        break;
      case WorkerType.once:
        if (!_sendOnce && (condition?.call(value) ?? true)) {
          _sendOnce = true;
          callback.call(value);
        }
        break;
      case WorkerType.interval:
        _timer ??= Timer.periodic(duration ?? 1.second, (_) {
          if (condition?.call(value) ?? true) callback.call(value);
        });
        break;
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
