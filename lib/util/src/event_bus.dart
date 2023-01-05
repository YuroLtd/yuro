import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:yuro/core/core.dart';
import 'package:yuro/state/state.dart';
import 'package:yuro/util/util.dart';

extension EventBusExt on YuroInterface {
  Stream<T> stream<T>() => Yuro.eventBus.stream.where((event) => event is T).cast<T>();

  Stream<Event> streamOn(int code1, [int? code2, int? code3, int? code4, int? code5, int? code6]) {
    final codes = [code1, code2, code3, code4, code5, code6].whereNotNull();
    return stream<Event>().where((event) => codes.contains(event.code));
  }

  void fire(dynamic event) => Yuro.eventBus.add(event);
}

class Event {
  final int code;
  final dynamic extra;

  Event(this.code, [this.extra]);

  void fire() => Yuro.fire(this);
}

bool _conditional(dynamic condition) {
  if (condition is bool) return condition;
  if (condition is bool Function()) return condition();
  return true;
}

typedef WorkerCallback<T> = void Function(T value);

class Worker<T> {
  final ObjectNotifier<T> notifier;
  final WorkerCallback<T> callback;
  final VoidCallback? onDone;

  late final StreamController<T> _controller;
  late final StreamSubscription<T> _subscription;
  bool _disposed = false;

  Worker._({required this.notifier, this.onDone, required this.callback}) {
    notifier.addListener(_notifierListener);
    _controller = StreamController<T>.broadcast();
    _subscription = _controller.stream.listen(callback, onDone: onDone, cancelOnError: true);
  }

  /// 接收[notifier]的每一次满足条件的变化
  factory Worker.every(
    ObjectNotifier<T> notifier,
    WorkerCallback<T> callback, {
    dynamic condition = true,
    VoidCallback? onDone,
  }) =>
      Worker<T>._(
          notifier: notifier,
          onDone: onDone,
          callback: (value) {
            if (_conditional(condition)) callback.call(value);
          });

  /// 只接收[notifier]的第一次满足条件的变化
  factory Worker.once(
    ObjectNotifier<T> notifier,
    WorkerCallback<T> callback, {
    dynamic condition = true,
    VoidCallback? onDone,
  }) {
    var recived = false;
    return Worker<T>._(
        notifier: notifier,
        onDone: onDone,
        callback: (value) {
          if (!recived && _conditional(condition)) {
            recived = true;
            callback.call(value);
          }
        });
  }

  /// 接收[notifier]满足条件的变化, 接收到初次变化后间隔[duration]后接收下一次变化
  factory Worker.interval(
    ObjectNotifier<T> notifier,
    WorkerCallback<T> callback, {
    dynamic condition = true,
    Duration duration = const Duration(seconds: 1),
    VoidCallback? onDone,
  }) {
    var actived = false;
    return Worker<T>._(
        notifier: notifier,
        onDone: onDone,
        callback: (value) async {
          if (actived || !_conditional(condition)) return;
          actived = true;
          callback.call(value);
          await Future.delayed(duration);
          actived = false;
        });
  }

  /// 只接收[notifier]单位时间[duration]内满足条件的最后一次变化
  factory Worker.debounce(
    ObjectNotifier<T> notifier,
    WorkerCallback<T> callback, {
    dynamic condition = true,
    Duration duration = const Duration(milliseconds: 800),
    VoidCallback? onDone,
  }) {
    T? t;
    final timer = Timer.periodic(duration, (_) {
      // ignore: null_check_on_nullable_type_parameter
      if (t.notNull) callback.call(t!);
    });
    return Worker<T>._(
        notifier: notifier,
        onDone: () {
          timer.cancel();
          onDone?.call();
        },
        callback: (value) async {
          if (!_conditional(condition)) return;
          t = value;
        });
  }

  void _notifierListener() {
    if (_disposed) return;
    _controller.add(notifier.value);
  }

  void dispose() async {
    if (_disposed) return;
    _disposed = true;
    notifier.removeListener(_notifierListener);
    await _controller.close();
    await _subscription.cancel();
  }
}
