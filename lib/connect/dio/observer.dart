import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:yuro/core/interface.dart';
import 'package:yuro/widgets/overlay/overlay.dart';

class Observer<T> {
  Observer(this.future);

  final Future<T> future;

  late final _stream = StreamController<T>.broadcast();

  StreamSubscription<T>? _subscription;

  bool _completed = false;

  bool get completed => _completed;

  bool _canceled = false;

  bool get canceled => _canceled;

  bool _loading = false;

  late final ValueSetter<T> _onDataFunc;
  late final ValueSetter<String>? _onErrorFunc;
  late final VoidCallback? _onDoneFunc;

  void listen({required ValueSetter<T> onData, ValueSetter<String>? onError, VoidCallback? onDone}) {
    _onDataFunc = onData;
    _onErrorFunc = onError;
    _onDoneFunc = onDone;
    _fetchData();
  }

  void loading({required ValueSetter<T> onData, ValueSetter<String>? onError, VoidCallback? onDone}) {
    _onDataFunc = onData;
    _onErrorFunc = onError;
    _onDoneFunc = onDone;
    _loading = true;

    Yuro.dismissLoading();
    Yuro.showLoading();
    _fetchData();
  }

  void _fetchData() async {
    try {
      _subscription = _stream.stream.listen(
        (event) => _onData(event),
        onError: (err, stackTrace) => _onError(err, stackTrace),
        cancelOnError: true,
      );
      _stream.add(await future);
    } catch (e, stackTrace) {
      _onError(e, stackTrace);
    }
  }

  void _onData(T event) {
    _onCompleted();
    _onDataFunc.call(event);
  }

  void _onError(Object err, stackTrace) {
    _onCompleted();
    if (err is DioException) {
      _onErrorFunc?.call(err.message ?? err.error.toString());
    } else {
      _onErrorFunc?.call(err.toString());
      Error.throwWithStackTrace(err, stackTrace);
    }
  }

  void _onCompleted() {
    _completed = true;
    _subscription = null;
    if (_loading) Yuro.dismissLoading();
    _onDoneFunc?.call();
  }

  Future<void> cancel() async {
    if (completed) return;
    await _subscription?.cancel();
    if (_loading) Yuro.dismissLoading();
    _canceled = true;
    _subscription = null;
  }
}
