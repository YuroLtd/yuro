import 'dart:async';

import 'package:dio/dio.dart';
import 'package:yuro/yuro_state/yuro_state.dart';

class Observer<T> {
  final Future<T> fetchData;

  Observer._(this.fetchData);

  StreamSubscription<T>? _subscription;

  factory Observer.fromFuture(Future<T> fetchData) => Observer._(fetchData);

  /// onStart -> onDone -> onData / onError
  void listen({
    void Function()? onStart,
    required void Function(T data) onData,
    Function(String err)? onError,
    void Function()? onDone,
  }) {
    onStart?.call();
    _subscription = Stream<T>.fromFuture(fetchData).listen(
      (event) {
        _onCompleted(onDone);
        onData.call(event);
      },
      onError: (err) {
        _onCompleted(onDone);
        onError?.call(err is DioError ? err.error.toString() : err.toString());
      },
      cancelOnError: true,
    );
  }

  void _onCompleted(void Function()? onDone) {
    _subscription = null;
    onDone?.call();
  }

  Future<void> cancel() async {
    await _subscription?.cancel();
  }
}

mixin ObserverMixin on YuroController {
  final List<Observer> observers = [];

  Observer<T> request<T>(Future<T> request) {
    final observer = Observer.fromFuture(request);
    observers.add(observer);
    return observer;
  }

  @override
  void dispose() {
    observers.forEach((element) => element.cancel());
    super.dispose();
  }
}
