import 'package:flutter/material.dart';
import 'package:yuro/yuro_core/yuro_core.dart';
import 'package:yuro/yuro_extension/src/list.dart';

class YuroWidgetsBindingObserver with WidgetsBindingObserver {
  final _popRouteListeners = <UniqueKey, ValueGetter<bool>>{};

  static final YuroWidgetsBindingObserver _instance = YuroWidgetsBindingObserver._();

  YuroWidgetsBindingObserver._() {
    WidgetsBinding.instance!.addObserver(this);
  }

  factory YuroWidgetsBindingObserver() => _instance;

  void addPopRouteListener(UniqueKey key, ValueGetter<bool> listener) => _popRouteListeners[key] = listener;

  void removePopRouteListener(UniqueKey key) => _popRouteListeners.remove(key);

  @override
  Future<bool> didPopRoute() {
    final clone = _popRouteListeners.values.toList().reverse();
    for (final element in clone) {
      if (element.call()) return Future<bool>.value(true);
    }
    return super.didPopRoute();
  }
}

class YuroNavigatorObserver extends NavigatorObserver {
  static final Set<NavigatorObserverProxy> proxies = {};

  static void register(NavigatorObserverProxy proxy) => proxies.add(proxy);

  static void unRegister(NavigatorObserverProxy proxy) => proxies.remove(proxy);

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    proxies.toList().forEach((element) => element.didPush?.call(route, previousRoute));
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    proxies.toList().forEach((element) => element.didReplace?.call(newRoute, oldRoute));
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    proxies.toList().forEach((element) => element.didRemove?.call(route, previousRoute));
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    proxies.toList().forEach((element) => element.didPop?.call(route, previousRoute));
  }
}

class NavigatorObserverProxy {
  void Function(Route<dynamic> route, Route<dynamic>? previousRoute)? didPush;

  void Function(Route<dynamic>? newRoute, Route<dynamic>? oldRoute)? didReplace;

  void Function(Route<dynamic> route, Route<dynamic>? previousRoute)? didRemove;

  void Function(Route<dynamic> route, Route<dynamic>? previousRoute)? didPop;

  NavigatorObserverProxy({this.didPush, this.didReplace, this.didRemove, this.didPop});

  NavigatorObserverProxy.all(VoidCallback callback) {
    didPush = (_, __) => callback();
    didReplace = (_, __) => callback();
    didRemove = (_, __) => callback();
    didPop = (_, __) => callback();
  }
}
