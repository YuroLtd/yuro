
import 'package:yuro/connect/dio/observer.dart';
import 'package:yuro/state/lifecycle.dart';


mixin HttpMixin on YuroLifeCycle {
  final List<Observer> observers = [];

  Observer<T> request<T>(Future<T> request) {
    // 添加之前,先清理掉已经完成或已取消的请求
    observers.removeWhere((element) => element.completed || element.canceled);
    final observer = Observer(request);
    observers.add(observer);
    return observer;
  }

  @override
  void dispose() {
    super.dispose();
    observers.where((e) => !e.completed && !e.canceled).forEach((e) => e.cancel());
  }
}
