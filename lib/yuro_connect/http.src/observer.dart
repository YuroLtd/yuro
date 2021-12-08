import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:yuro/yuro_core/yuro_core.dart';
import 'package:yuro/yuro_overlay/src/loading/loading.dart';

class Observer<T> {
  final Future<T> _fetchData;

  Observer._(this._fetchData);

  StreamSubscription<T>? _subscription;
  UniqueKey? _uniqueKey;

  bool completed = false;
  bool canceled = false;

  factory Observer.fromFuture(Future<T> fetchData) => Observer._(fetchData);

  late final ValueSetter<T> onData;
  late final ValueSetter<String>? onError;
  late final VoidCallback? onDone;

  void fetch({required ValueSetter<T> onData, ValueSetter<String>? onError, VoidCallback? onDone}) {
    this.onData = onData;
    this.onError = onError;
    this.onDone = onDone;
    _subscription = Stream<T>.fromFuture(_fetchData).listen(
      (event) => _onData(event),
      onError: (err) => _onError(err),
      cancelOnError: true,
    );
  }

  void listen({required ValueSetter<T> onData, ValueSetter<String>? onError, VoidCallback? onDone}) {
    this.onData = onData;
    this.onError = onError;
    this.onDone = onDone;
    _uniqueKey = Yuro.showLoading(() => cancel());
    _subscription = Stream<T>.fromFuture(_fetchData).listen(
      (event) => _onData(event),
      onError: (err) => _onError(err),
      cancelOnError: true,
    );
  }

  void _onData(T event) {
    _onCompleted();
    onData.call(event);
  }

  void _onError(dynamic err) {
    _onCompleted();
    onError?.call(err is DioError ? err.error.toString() : err.toString());
  }

  void _onCompleted() {
    completed = true;
    _subscription = null;
    onDone?.call();
    if (_uniqueKey != null) Yuro.dismissLoading(_uniqueKey);
  }

  Future<void> cancel() async {
    await _subscription?.cancel();
    canceled = true;
    _subscription = null;
  }
}
