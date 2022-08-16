import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class Observer<T> {
  Observer._(this._fetchData);

  factory Observer.fromFuture(Future<T> fetchData) => Observer._(fetchData);

  final Future<T> _fetchData;

  StreamSubscription<T>? _subscription;

  bool _completed = false;

  bool get completed => _completed;

  bool _canceled = false;

  bool get canceled => _canceled;

  late final ValueSetter<T> _onDataFunc;
  late final ValueSetter<String>? _onErrorFunc;
  late final VoidCallback? _onDoneFunc;

  void subscribe({
    VoidCallback? onStart,
    required ValueSetter<T> onData,
    ValueSetter<String>? onError,
    VoidCallback? onDone,
  }) {
    _onDataFunc = onData;
    _onErrorFunc = onError;
    _onDoneFunc = onDone;
    _subscription = Stream<T>.fromFuture(_fetchData).listen(
      (event) => _onData(event),
      onError: (err) => _onError(err),
      cancelOnError: true,
    );
    onStart?.call();
  }

  void _onData(T event) {
    _onCompleted();
    _onDataFunc.call(event);
  }

  void _onError(dynamic err) {
    _onCompleted();
    _onErrorFunc?.call(err is DioError ? err.error.toString() : err.toString());
  }

  void _onCompleted() {
    _completed = true;
    _subscription = null;
    _onDoneFunc?.call();
  }

  Future<void> cancel() async {
    if (!completed) {
      await _subscription?.cancel();
      _canceled = true;
      _subscription = null;
    }
  }
}
