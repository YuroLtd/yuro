import 'package:flutter/widgets.dart';
import 'package:yuro/router/router.dart';

class YuroPageObserver extends NavigatorObserver {
  static final Map<PageSettings, Set<PageAware>> _map = {};

  static void register(PageSettings settings, PageAware aware) {
    final awares = _map.putIfAbsent(settings, () => <PageAware>{});
    if (awares.add(aware)) aware.didPush();
  }

  static void unRegister(PageSettings decoder, PageAware aware) {
    final awares = _map[decoder];
    if (awares != null && awares.contains(aware)) {
      awares.remove(aware);
      if (awares.isEmpty) _map.remove(decoder);
    }
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (route is YuroPageRoute && previousRoute is YuroPageRoute) {
      _map[previousRoute.settings.arguments]?.forEach((element) => element.didPushNext());
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (route is YuroPageRoute && previousRoute is YuroPageRoute) {
      _map[previousRoute.settings.arguments]?.forEach((element) => element.didPopNext());
      _map[route.settings.arguments]?.forEach((element) => element.didPop());
    }
  }
}

abstract class PageAware {
  /// 上层的页面弹出
  void didPopNext() {}

  /// 当前页面出栈
  void didPop() {}

  /// 当前页面入栈
  void didPush() {}

  /// 从当前页面压入新的页面
  void didPushNext() {}
}
