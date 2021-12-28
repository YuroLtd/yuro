import 'package:flutter/material.dart';

import 'navigator_observer_proxy.dart';

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
