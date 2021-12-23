import 'package:flutter/widgets.dart';
import 'package:yuro/yuro_core/yuro_core.dart';
import 'package:yuro/yuro_app/yuro_app.dart';

extension YuroRouteExt on YuroInterface {
  Future<T?> push<T>(Route<T> route) {
    return currentState.push(route);
  }

  Future<T?> pushNamed<T>(String routeName, {Object? arguments}) {
    return currentState.pushNamed(routeName, arguments: arguments);
  }

  Future<T?> pushReplacement<T, TO>(Route<T> newRoute, {TO? result}) {
    return currentState.pushReplacement(newRoute, result: result);
  }

  Future<T?> pushReplacementNamed<T, TO>(String routeName, {TO? result, Object? arguments}) {
    return currentState.pushReplacementNamed(routeName, result: result, arguments: arguments);
  }

  Future<T?> pushAndRemoveUntil<T>(Route<T> newRoute, RoutePredicate predicate) {
    return currentState.pushAndRemoveUntil(newRoute, predicate);
  }

  Future<T?> pushNamedAndRemoveUntil<T>(String newRouteName, RoutePredicate predicate, {Object? arguments}) {
    return currentState.pushNamedAndRemoveUntil(newRouteName, predicate, arguments: arguments);
  }

  void pop<T>([T? result]) {
    return currentState.pop(result);
  }

  void popUntil(RoutePredicate predicate) {
    return currentState.popUntil(predicate);
  }

  Future<T?> popAndPushNamed<T, TO>(String routeName, {TO? result, Object? arguments}) {
    return currentState.popAndPushNamed(routeName, result: result, arguments: arguments);
  }

  void removeRoute(Route<dynamic> route) {
    return currentState.removeRoute(route);
  }

  void removeRouteBelow(Route<dynamic> anchorRoute) {
    return currentState.removeRouteBelow(anchorRoute);
  }

  void replace<T>({required Route<dynamic> oldRoute, required Route<T> newRoute}) {
    return currentState.replace(oldRoute: oldRoute, newRoute: newRoute);
  }

  void replaceRouteBelow<T>({required Route<dynamic> anchorRoute, required Route<T> newRoute}) {
    return currentState.replaceRouteBelow(anchorRoute: anchorRoute, newRoute: newRoute);
  }

  bool canPop() {
    return currentState.canPop();
  }
}
