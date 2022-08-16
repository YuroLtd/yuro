import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:yuro/logger/logger.dart';
import 'package:yuro/router/router.dart';


// 路由中间件,负责路由拦截和重定向
// 完整的生命周期为:
//  pageCalled >> redirect >> onPageBuildStart >> onPageBuildEnd >> onPageDispose

abstract class Middleware {
  /// 值越大优先级越高
  int priority = 0;

  /// 页面被点名时调用
  YuroPage pageCalled(YuroPage page) => page;

  /// 重定向到指定路由,[PageRedirect]触发
  RouteSettings? redirect(String route) => null;

  /// 重定向到指定路由,[YuroPageRoute]触发
  Future<RouteDecoder?> redirectDelegate(RouteDecoder? route) => SynchronousFuture(route);

  /// 页面构建前调用
  PageBuilder pageBuildStart(PageBuilder builder) => builder;

  /// 页面构建完后调用
  Widget pageBuildEnd(Widget widget) => widget;

  /// 页面销毁后调用
  void pageDispose() {}
}

// 中间件执行器
class MiddlewareRunner {
  MiddlewareRunner(List<Middleware>? middlewares) {
    // 从大到小进行排序
    this.middlewares = (middlewares?..sort((a, b) => b.priority.compareTo(a.priority))) ?? [];
  }

  late final List<Middleware> middlewares;
  late final _logger = Logger('MiddlewareRunner');

  RouteSettings? runRedirect(String route) {
    _logger.v('[Redirect] $route');
    RouteSettings? to;
    for (final element in middlewares) {
      to = element.redirect(route);
      if (to != null) break;
    }
    return to;
  }

  YuroPage runPageCalled(YuroPage page) {
    _logger.v('[Called] ${page.name}');
    for (final element in middlewares) {
      page = element.pageCalled(page);
    }
    return page;
  }

  PageBuilder runPageBuildStart(PageBuilder builder) {
    for (final element in middlewares) {
      builder = element.pageBuildStart(builder);
    }
    return builder;
  }

  Widget runPageBuildEnd(Widget widget) {
    for (final element in middlewares) {
      widget = element.pageBuildEnd(widget);
    }
    return widget;
  }

  void runPageDispose(YuroPage page) {
    _logger.v('[Dispose] ${page.name}');
    for (final element in middlewares) {
      element.pageDispose();
    }
  }
}
