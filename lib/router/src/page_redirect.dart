
import 'package:flutter/widgets.dart';
import 'package:yuro/core/core.dart';
import 'package:yuro/router/router.dart';

/// 负责页面重定向
class PageRedirect{
  YuroPage page;
  YuroPage? unknownPage;

  bool isUnknown = false;
  RouteSettings? settings;

  PageRedirect(this.page, this.unknownPage);

  YuroPageRoute<T> pageRoute<T>() {
    while (needRecheck()) {}
    final r = isUnknown ? (unknownPage ?? Yuro.routeDelegate.unknownPage) : page;
    final s = isUnknown ? RouteSettings(name: r.name, arguments: settings?.arguments) : settings;
    return YuroPageRoute<T>(
      page: r,
      settings: s,
      maintainState: r.maintainState,
      fullscreenDialog: r.fullscreenDialog,
      barrierColor: r.barrierColor,
      barrierLabel: r.barrierLabel,
      customTransition: r.customTransition,
      transitionDuration: r.transitionDuration,
      reverseTransitionDuration: r.reverseTransitionDuration,
      opaque: r.opaque,
      barrierDismissible: r.barrierDismissible,
    );
  }

  bool needRecheck() {
    settings ??= page;

    final match = Yuro.routeTree.matchRoute(settings!.name!);
    // 路由未找到,结束循环检查,跳转到未找到页面
    if (match.page == null) {
      isUnknown = true;
      return false;
    }
    final runner = MiddlewareRunner(match.page!.middlewares);
    page = runner.runPageCalled(match.page!);
    if (runner.middlewares.isEmpty) return false;

    // 检查是否需要重定向
    final newRouteSetting = runner.runRedirect(match.page!.name);
    if (newRouteSetting == null) return false;

    settings == newRouteSetting;
    return true;
  }
}