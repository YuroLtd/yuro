
import 'dart:async';
import 'package:dio/dio.dart';

import 'package:yuro/yuro_core/yuro_core.dart';

import 'util.dart';

class Observer<T> {
  final Future<T> fetchData;

  Observer._(this.fetchData);

  StreamSubscription<T>? _subscription;

  factory Observer.fromFetch(Future<T> fetchData) => Observer._(fetchData);

  void listen({VoidFunction? onListen, required ValueFunction<T> onData, Function(HttpError err)? onError, VoidFunction? onDone}) {
    onListen?.call();
    _subscription = Stream<T>.fromFuture(fetchData).listen(
      onData,
      onError: (err) {
        var httpError = err is DioError ? err.error as HttpError : HttpError(-1, err.toString());
        onError?.call(httpError);
        onDone?.call();
      },
      onDone: () {
        _subscription = null;
        onDone?.call();
      },
      cancelOnError: true,
    );
  }

  Future<void> cancel() async {
    await _subscription?.cancel();
  }
}