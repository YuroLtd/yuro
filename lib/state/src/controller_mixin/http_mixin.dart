import 'package:yuro/connect/http.src/observer.dart';

import '../yuro_controller.dart';

mixin HttpMixin on YuroController {
  final List<Observer> observers = [];

  Observer<T> request<T>(Future<T> request) {
    // 添加之前,先清理掉已经完成或取消了的请求
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
