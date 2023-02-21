library route;

import 'package:flutter/material.dart';
import 'package:yuro/core/core.dart';
import 'package:yuro/util/util.dart';

import 'src/middleware.dart';
import 'src/page.dart';
import 'src/route_delegate.dart';
import 'src/route_parser.dart';
import 'src/route_tree.dart';

export 'src/middleware.dart';
export 'src/page.dart';
export 'src/page_redirect.dart';
export 'src/page_route.dart';
export 'src/route_decoder.dart';
export 'src/route_delegate.dart';
export 'src/route_parser.dart';
export 'src/route_tree.dart';
export 'src/page_observer.dart';

extension YuroRouterExt on YuroInterface {
  static final _routeTree = RouteTree();

  RouteTree get routeTree => _routeTree;

  void addPages(List<YuroPage> pages) => _routeTree.addPages(pages);

  void addPage(YuroPage page) => _routeTree.addPage(page);

  void removePage(YuroPage page) => _routeTree.removePage(page);

  //
  static YuroRouteParser? _routeParser;

  YuroRouteParser createRouteParser(String initialRoute) =>
      _routeParser ??= YuroRouteParser(initialRoute: initialRoute);

  //
  static YuroRouteDelegate? _routeDelegate;

  YuroRouteDelegate get routeDelegate => _routeDelegate!;

  BuildContext get currentContext => routeDelegate.navigatorKey.currentContext!;

  NavigatorState get navigator => Navigator.of(currentContext);

  YuroRouteDelegate createRouterDelegate({
    required List<YuroPage> pages,
    YuroPage? unknownPage,
    GlobalKey<NavigatorState>? navigatorKey,
    List<NavigatorObserver>? navigatorObservers,
  }) =>
      _routeDelegate ??= YuroRouteDelegate(
        pages: pages,
        unknownPage: unknownPage,
        navigatorKey: navigatorKey,
        navigatorObservers: navigatorObservers,
      );

  String _buildNewName(String name, Map<String, String>? parameters) {
    return (parameters.isNullOrEmpty ? Uri(path: name) : Uri(path: name, queryParameters: parameters)).toString();
  }

  String _cleanRouteName(String name) {
    name = name.replaceAll('() => ', '');
    if (!name.startsWith('/')) name = '/$name';
    return Uri.tryParse(name)?.toString() ?? name;
  }

  Future<T?> push<T>(
    PageBuilder builder, {
    String? name,
    Map<String, String>? parameters,
    Object? arguments,
    List<Middleware>? middlewares,
    String? restorationId,
    bool? maintainState,
    bool? fullscreenDialog,
    Color? barrierColor,
    String? barrierLabel,
    Duration? transitionDuration,
    Duration? reverseTransitionDuration,
    bool? opaque,
    bool? barrierDismissible,
  }) async {
    name = _cleanRouteName(name ?? '/${builder.runtimeType}');
    final page = YuroPage(
      name: name,
      builder: builder,
      arguments: arguments,
      middlewares: middlewares,
      restorationId: restorationId,
      maintainState: maintainState ?? true,
      fullscreenDialog: fullscreenDialog ?? false,
      barrierColor: barrierColor,
      barrierLabel: barrierLabel,
      transitionDuration: transitionDuration ?? const Duration(milliseconds: 300),
      reverseTransitionDuration: reverseTransitionDuration ?? const Duration(milliseconds: 300),
      opaque: opaque ?? true,
      barrierDismissible: barrierDismissible ?? false,
    );

    addPage(page);
    final result = await pushNamed<T>(page.name, parameters: parameters, arguments: arguments);
    removePage(page);
    return result;
  }

  Future<T?> pushNamed<T>(
    String name, {
    Map<String, String>? parameters,
    Object? arguments,
  }) =>
      routeDelegate.pushNamed<T>(
        _buildNewName(name, parameters),
        arguments: arguments,
      );

  @Deprecated('bug')
  Future<R?> pushReplacement<T, R>(
    PageBuilder builder, {
    T? result,
    String? name,
    Map<String, String>? parameters,
    Object? arguments,
    List<Middleware>? middlewares,
    String? restorationId,
    bool? maintainState,
    bool? fullscreenDialog,
    Color? barrierColor,
    String? barrierLabel,
    Duration? transitionDuration,
    Duration? reverseTransitionDuration,
    bool? opaque,
    bool? barrierDismissible,
  }) async {
    name = _cleanRouteName(name ?? '/${builder.runtimeType}');
    final page = YuroPage(
      name: name,
      builder: builder,
      arguments: arguments,
      middlewares: middlewares,
      restorationId: restorationId,
      maintainState: maintainState ?? true,
      fullscreenDialog: fullscreenDialog ?? false,
      barrierColor: barrierColor,
      barrierLabel: barrierLabel,
      transitionDuration: transitionDuration ?? const Duration(milliseconds: 300),
      reverseTransitionDuration: reverseTransitionDuration ?? const Duration(milliseconds: 300),
      opaque: opaque ?? true,
      barrierDismissible: barrierDismissible ?? false,
    );

    addPage(page);
    final future = await pushReplacementNamed<T, R>(
      page.name,
      parameters: parameters,
      result: result,
      arguments: arguments,
    );
    removePage(page);
    return future;
  }
  
  @Deprecated('bug')
  Future<R?> pushReplacementNamed<T, R>(
    String name, {
    Map<String, String>? parameters,
    T? result,
    Object? arguments,
  }) =>
      routeDelegate.pushReplacementNamed<T, R>(
        _buildNewName(name, parameters),
        result: result,
        arguments: arguments,
      );

  Future<T?> pushAndRemoveUntil<T>(
    PageBuilder builder,
    PagePredicate predicate, {
    String? name,
    Map<String, String>? parameters,
    Object? arguments,
    List<Middleware>? middlewares,
    String? restorationId,
    bool? maintainState,
    bool? fullscreenDialog,
    Color? barrierColor,
    String? barrierLabel,
    Duration? transitionDuration,
    Duration? reverseTransitionDuration,
    bool? opaque,
    bool? barrierDismissible,
  }) async {
    name = _cleanRouteName(name ?? '/${builder.runtimeType}');
    final page = YuroPage(
      name: name,
      builder: builder,
      arguments: arguments,
      middlewares: middlewares,
      restorationId: restorationId,
      maintainState: maintainState ?? true,
      fullscreenDialog: fullscreenDialog ?? false,
      barrierColor: barrierColor,
      barrierLabel: barrierLabel,
      transitionDuration: transitionDuration ?? const Duration(milliseconds: 300),
      reverseTransitionDuration: reverseTransitionDuration ?? const Duration(milliseconds: 300),
      opaque: opaque ?? true,
      barrierDismissible: barrierDismissible ?? false,
    );

    addPage(page);
    final result = await pushNamedAndRemoveUntil<T>(
      page.name,
      predicate,
      parameters: parameters,
      arguments: arguments,
    );
    removePage(page);
    return result;
  }

  Future<T?> pushNamedAndRemoveUntil<T>(
    String name,
    PagePredicate predicate, {
    Map<String, String>? parameters,
    Object? arguments,
  }) =>
      routeDelegate.pushNamedAndRemoveUntil<T>(
        _buildNewName(name, parameters),
        predicate,
        arguments: arguments,
      );

  /// 仅用于页面弹出, 以下弹出使用[navigator]的pop方法
  /// * [showModalBottomSheet]
  void pop<T>([T? result]) {
    if (routeDelegate.canPop()) {
      routeDelegate.pop(result);
    }
  }

  /// 弹出路由栈中指定页面之上的所有页面
  void popUntil(PagePredicate predicate) {
    routeDelegate.popUntil(predicate);
  }

  Future<R?> popAndPush<T, R>(
    PageBuilder builder, {
    T? result,
    String? name,
    Map<String, String>? parameters,
    Object? arguments,
    List<Middleware>? middlewares,
    String? restorationId,
    bool? maintainState,
    bool? fullscreenDialog,
    Color? barrierColor,
    String? barrierLabel,
    Duration? transitionDuration,
    Duration? reverseTransitionDuration,
    bool? opaque,
    bool? barrierDismissible,
  }) async {
    name = _cleanRouteName(name ?? '/${builder.runtimeType}');
    final page = YuroPage(
      name: name,
      builder: builder,
      arguments: arguments,
      middlewares: middlewares,
      restorationId: restorationId,
      maintainState: maintainState ?? true,
      fullscreenDialog: fullscreenDialog ?? false,
      barrierColor: barrierColor,
      barrierLabel: barrierLabel,
      transitionDuration: transitionDuration ?? const Duration(milliseconds: 300),
      reverseTransitionDuration: reverseTransitionDuration ?? const Duration(milliseconds: 300),
      opaque: opaque ?? true,
      barrierDismissible: barrierDismissible ?? false,
    );

    addPage(page);
    final future = await popAndPushNamed<T, R>(
      page.name,
      parameters: parameters,
      arguments: arguments,
      result: result,
    );
    removePage(page);
    return future;
  }

  /// 弹出当前页面后推送新的命名路由
  Future<R?> popAndPushNamed<T, R>(
    String name, {
    Map<String, String>? parameters,
    Object? arguments,
    T? result,
  }) =>
      routeDelegate.popAndPushNamed<T, R>(
        _buildNewName(name, parameters),
        result: result,
        arguments: arguments,
      );

  /// 移除栈中的指定页面
  void removeRoute(PagePredicate predicate) {
    routeDelegate.removeRoute(predicate);
  }

  /// 移除路由栈中指定页面之下的所有页面
  void removeRouteBelow(PagePredicate predicate) {
    routeDelegate.removeRouteBelow(predicate);
  }
}

extension PageNameExt on String {
  String params(Map<String, String> params) {
    final regExp = RegExp(r'(\.)?:(\w+)?');
    // 查找所有的路径参数
    final keys = regExp.allMatches(this).map((match) => match[2]).whereNotNull().toList();
    if (keys.isNotEmpty) {
      // 判断除路径参数都必须在[parameters]中存在
      final missing = keys.where((e) => !params.containsKey(e)).toList();
      if (missing.isNotEmpty) {
        throw IllagalArgumentError(missing.join(', '), this);
      }
      // 替换路径中的参数
      return replaceAllMapped(regExp, (match) => params[match[2]]!);
    }
    return this;
  }
}
