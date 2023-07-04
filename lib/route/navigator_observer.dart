import 'package:flutter/widgets.dart';
import 'package:yuro/state/mixin/navigator_mixin.dart';

class YuroNavigatorObserver extends NavigatorObserver {
  static final Map<String, NavigatorMixin> _map = {};

  static void register(String routeName, NavigatorMixin navigator) => _map[routeName] = navigator;

  static void unRegister(String routeName) => _map.remove(routeName);

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _map[previousRoute?.settings.name]?.didPushNext();
    _map[route.settings.name]?.didPush();
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _map[previousRoute?.settings.name]?.didPopNext();
    _map[route.settings.name]?.didPop();
  }
}
