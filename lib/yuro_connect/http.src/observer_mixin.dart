import 'package:yuro/yuro_state/yuro_state.dart';

import 'observer.dart';

mixin ObserverMixin on YuroController {
  final List<Observer> observers = [];

  Observer<T> request<T>(Future<T> request) {
    // 添加之前,先清理掉已经完成或取消了的请求
    observers.removeWhere((element) => element.completed || element.canceled);
    final observer = Observer.fromFuture(request);
    observers.add(observer);
    return observer;
  }

  @override
  void dispose() {
    // 取消未完成的请求的订阅,主要针对于使用fetch方式的请求
    observers.where((element) => !element.completed && !element.canceled).forEach((element) => element.cancel());
    super.dispose();
  }
}
