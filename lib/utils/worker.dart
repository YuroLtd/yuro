// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:yuro/core/core.dart';
// import 'package:yuro/state/state.dart';

// bool _conditional(dynamic condition) {
//   if (condition is bool) return condition;
//   if (condition is bool Function()) return condition();
//   return true;
// }

// typedef WorkerCallback<T> = void Function(T value);

// class Worker<T> {
//   final ValueSetter<T?> callback;
//   final Disposer? disposer;

//   late final StreamController<T?> _controller;
//   late final StreamSubscription<T?> _subscription;

//   late ObjectNotifier<T?> _notifier;

//   bool _disposed = false;

//   Worker._(this.callback, {this.disposer}) {
//     _notifier = ObjectNotifier(null);
//     _notifier.addListener(_notifierListener);
//     _controller = StreamController<T>.broadcast();
//     _subscription = _controller.stream.listen(callback, cancelOnError: true);
//   }

//   void _notifierListener() {
//     if (_disposed) return;
//     _controller.add(_notifier.value);
//   }

//   void setNotifier(ObjectNotifier<T?> notifier) {
//     _notifier.removeListener(_notifierListener);
//     _notifier = notifier;
//     _notifier.addListener(_notifierListener);
//   }

//   void notifier(T? data) => _notifier.value = data;

//   void dispose() async {
//     if (_disposed) return;
//     _disposed = true;
//     disposer?.call();
//     _notifier.removeListener(_notifierListener);
//     await _controller.close();
//     await _subscription.cancel();
//   }

//   /// 接收[notifier]的每一次满足条件的变化
//   factory Worker.every(
//     ValueSetter<T?> callback, {
//     dynamic condition = true,
//   }) =>
//       Worker<T>._((value) {
//         if (_conditional(condition)) callback.call(value);
//       });

//   /// 只接收[notifier]的第一次满足条件的变化
//   factory Worker.once(
//     ValueSetter<T?> callback, {
//     dynamic condition = true,
//     VoidCallback? onDone,
//   }) {
//     var recived = false;
//     return Worker<T>._((value) {
//       if (!recived && _conditional(condition)) {
//         recived = true;
//         callback.call(value);
//       }
//     });
//   }

//   /// 接收[notifier]满足条件的变化, 接收到初次变化后间隔[duration]后接收下一次变化
//   factory Worker.interval(
//     ValueSetter<T?> callback, {
//     dynamic condition = true,
//     Duration duration = const Duration(seconds: 1),
//   }) {
//     var actived = false;
//     return Worker<T>._((value) async {
//       if (actived || !_conditional(condition)) return;
//       actived = true;
//       callback.call(value);
//       await Future.delayed(duration);
//       actived = false;
//     });
//   }

//   /// 只接收[notifier]单位时间[duration]内满足条件的最后一次变化
//   factory Worker.debounce(
//     ValueSetter<T?> callback, {
//     dynamic condition = true,
//     Duration duration = const Duration(milliseconds: 800),
//   }) {
//     T? t;
//     final timer = Timer.periodic(duration, (_) => callback.call(t));
//     return Worker<T>._((value) {
//       if (_conditional(condition)) t = value;
//     }, disposer: () => timer.cancel());
//   }
// }
