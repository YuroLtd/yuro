import 'package:flutter/widgets.dart';
import 'package:yuro/yuro_core/yuro_core.dart';

class _YuroRoute {
  late GlobalKey<NavigatorState> navigatorKey;
}

extension YuroRouteExt on YuroInterface {
  static _YuroRoute _yuroRoute = _YuroRoute();

  GlobalKey<NavigatorState> get navigatorKey => _yuroRoute.navigatorKey;

  set navigatorKey(GlobalKey<NavigatorState> navigatorKey) => _yuroRoute.navigatorKey = navigatorKey;

  BuildContext get currentContext => navigatorKey.currentContext!;

  NavigatorState get currentState => navigatorKey.currentState!;
}

extension NavigatorExt on YuroInterface {
  Future<T?> push<T>(Route<T> route) {
    return Yuro.currentState.push(route);
  }

  Future<T?> pushNamed<T>(String routeName, {Object? arguments}) {
    return Yuro.currentState.pushNamed(routeName, arguments: arguments);
  }

  Future<T?> pushReplacement<T, TO>(Route<T> newRoute, {TO? result}) {
    return Yuro.currentState.pushReplacement(newRoute, result: result);
  }

  Future<T?> pushReplacementNamed<T, TO>(String routeName, {TO? result, Object? arguments}) {
    return Yuro.currentState.pushReplacementNamed(routeName, result: result, arguments: arguments);
  }

  Future<T?> pushAndRemoveUntil<T>(Route<T> newRoute, RoutePredicate predicate) {
    return Yuro.currentState.pushAndRemoveUntil(newRoute, predicate);
  }

  Future<T?> pushNamedAndRemoveUntil<T>(String newRouteName, RoutePredicate predicate, {Object? arguments}) {
    return Yuro.currentState.pushNamedAndRemoveUntil(newRouteName, predicate, arguments: arguments);
  }

  void pop<T>([T? result]) {
    return Yuro.currentState.pop(result);
  }

  void popUntil(RoutePredicate predicate) {
    return Yuro.currentState.popUntil(predicate);
  }

  Future<T?> popAndPushNamed<T, TO>(String routeName, {TO? result, Object? arguments}) {
    return Yuro.currentState.popAndPushNamed(routeName, result: result, arguments: arguments);
  }

  void removeRoute(Route<dynamic> route) {
    return Yuro.currentState.removeRoute(route);
  }

  void removeRouteBelow(Route<dynamic> anchorRoute) {
    return Yuro.currentState.removeRouteBelow(anchorRoute);
  }

  void replace<T>({required Route<dynamic> oldRoute, required Route<T> newRoute}) {
    return Yuro.currentState.replace(oldRoute: oldRoute, newRoute: newRoute);
  }

  void replaceRouteBelow<T>({required Route<dynamic> anchorRoute, required Route<T> newRoute}) {
    return Yuro.currentState.replaceRouteBelow(anchorRoute: anchorRoute, newRoute: newRoute);
  }

  bool canPop() {
    return Yuro.currentState.canPop();
  }
}
