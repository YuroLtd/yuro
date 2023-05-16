import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:yuro/core/core.dart';
import 'package:yuro/state/state.dart';
import 'package:yuro/widget/widget.dart';

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

  ///
  /// [delay] 延迟请求
  void listen({
    required ValueSetter<T> onData,
    ValueSetter<String>? onError,
    VoidCallback? onDone,
    Widget? loading,
    Duration delay = const Duration(milliseconds: 500),
  }) async {
    _onDataFunc = onData;
    _onErrorFunc = onError;
    _onDoneFunc = onDone;

    if (loading != null) {
      Yuro.dismissLoading();
      Yuro.showLoading(child: loading, onDismiss: cancel);
    }
    await Future.delayed(delay);
    _subscription = Stream<T>.fromFuture(_fetchData).listen(
      (event) => _onData(event),
      onError: (err, stackTrace) => _onError(err, stackTrace),
      cancelOnError: true,
    );
  }

  void _onData(T event) {
    _onCompleted();
    _onDataFunc.call(event);
  }

  void _onError(Object err, stackTrace) {
    _onCompleted();
    if (err is DioError) {
      _onErrorFunc?.call(err.message ?? err.error.toString());
    } else {
      Error.throwWithStackTrace(err, stackTrace);
    }
  }

  void _onCompleted() {
    _completed = true;
    _subscription = null;
    Yuro.dismissLoading();
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

mixin HttpMixin on YuroController {
  final List<Observer> observers = [];

  Observer<T> request<T>(Future<T> request) {
    // 添加之前,先清理掉已经完成或已取消的请求
    observers.removeWhere((element) => element.completed || element.canceled);
    final observer = Observer.fromFuture(request);
    observers.add(observer);
    return observer;
  }

  @override
  void onDispose() {
    observers.where((element) => !element.completed && !element.canceled).forEach((element) => element.cancel());
    super.onDispose();
  }
}