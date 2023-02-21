import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:yuro/core/core.dart';
import 'package:yuro/router/router.dart';
import 'package:yuro/util/util.dart';
import 'package:yuro/widget/overlay/overlay.dart';

import 'page_observer.dart';

mixin RouteDelegateMixin {
  /// 推送命名路由
  Future<T?> pushNamed<T>(String name, {Object? arguments});

  /// 推送替换当前的命名路由
  Future<R?> pushReplacementNamed<T, R>(String name, {T? result, Object? arguments});

  /// 推送命名路由后, 从该路由之下开始移除, 直到指定页面
  Future<T?> pushNamedAndRemoveUntil<T>(String name, PagePredicate predicate, {Object? arguments});

  /// 弹出路由栈的栈顶页面
  void pop<T>([T? result]);

  /// 弹出路由栈中指定页面之上的所有页面
  void popUntil(PagePredicate predicate);

  /// 弹出当前页面后推送新的命名路由
  Future<R?> popAndPushNamed<T, R>(String name, {T? result, Object? arguments});

  /// 移除栈中的指定页面
  void removeRoute(PagePredicate predicate);

  /// 移除路由栈中指定页面之下的所有页面
  void removeRouteBelow(PagePredicate predicate);
}

/// 路由委托
class YuroRouteDelegate extends RouterDelegate<RouteDecoder>
    with PopNavigatorRouterDelegateMixin<RouteDecoder>, ChangeNotifier, RouteDelegateMixin {
  final YuroPage unknownPage;
  final List<NavigatorObserver> navigatorObservers;

  final _activePages = <RouteDecoder>[];
  late final _logger = Yuro.tag('RouteDelegate');

  YuroRouteDelegate({
    required List<YuroPage> pages,
    YuroPage? unknownPage,
    GlobalKey<NavigatorState>? navigatorKey,
    List<NavigatorObserver>? navigatorObservers,
  })  : navigatorKey = navigatorKey ?? GlobalKey<NavigatorState>(),
        navigatorObservers = navigatorObservers ?? const [],
        unknownPage = unknownPage ??= YuroPage(
          name: '/404',
          builder: () => const Scaffold(body: Center(child: Text('Route not found'))),
        ) {
    Yuro.addPages(pages);
    Yuro.addPage(unknownPage);
    _logger.v('created!');
  }

  @override
  GlobalKey<NavigatorState> navigatorKey;

  @override
  RouteDecoder? get currentConfiguration => _activePages.lastOrNull;

  @override
  Future<void> setNewRoutePath(RouteDecoder configuration) async {
    configuration.page == null ? _toUnknownPage() : _push(configuration);
    return SynchronousFuture(null);
  }

  @override
  Widget build(BuildContext context) {
    List<YuroPage> pages = currentConfiguration == null ? [] : _activePages.map((e) => e.page!).toList();
    return pages.isEmpty
        ? ColoredBox(color: Theme.of(context).scaffoldBackgroundColor)
        : Navigator(
            key: navigatorKey,
            pages: pages,
            observers: [YuroPageObserver(), ...navigatorObservers],
            onPopPage: _onPopPage,
            // transitionDelegate:
          );
  }

  bool _onPopPage(Route route, dynamic result) {
    // 判断是否有Overlay显示,如有则弹出
    if (Yuro.hasOverlayShow()) {
      Yuro.dismissOverlay();
      return false;
    }

    final didPop = route.didPop(result);
    if (didPop) {
      // 弹出成功,从历史栈中移除
      final setting = route.settings;
      if (setting is YuroPage) {
        final decoder = _activePages.firstWhereOrNull((e) => e.page == setting);
        if (decoder != null) _historyRemove(decoder, result);
      }
      notifyListeners();
    }
    return didPop;
  }

  Future<T?> _historyRemove<T>(RouteDecoder decoder, T result) async {
    var index = _activePages.indexOf(decoder);
    if (index >= 0) return _historyRemoveAt(index, result);
    return null;
  }

  Future<T?> _historyRemoveAt<T>(int index, dynamic result) async {
    final completer = _activePages.removeAt(index).completer;
    if (completer != null && !completer.isCompleted) completer.complete(result);
    return completer?.future as T?;
  }

  // 根据PageSetting查找RouteDecoder
  RouteDecoder? _getRouteDecoder<T>(String name, [Object? data]) {
    final setting = PageSettings.fromUrl(name, data);
    final decoder = Yuro.routeTree.matchRoute(setting.name, setting);
    if (decoder.page == null) return null;
    decoder.completer = _activePages.isEmpty ? null : Completer<T?>();
    return decoder;
  }

  // 执行Middleware
  Future<RouteDecoder?> _runMiddleware(RouteDecoder? decoder) async {
    final middlewares = decoder?.page?.middlewares;
    if (middlewares.isNullOrEmpty) return decoder;
    for (final element in middlewares!) {
      decoder = await element.redirectDelegate(decoder);
      if (decoder == null) break;
    }
    return decoder;
  }

  Future<T?> _push<T>(RouteDecoder decoder, [bool rebuildStack = true]) async {
    final runRes = await _runMiddleware(decoder) ?? decoder;
    // 使用路径来判定是否为同一个页面, 如果查询参数或传参不同则刷新页面, 否则不做任何动作
    final inStack = _activePages.firstWhereOrNull((element) => element.settings?.path == runRes.settings?.path);
    if (inStack != null) {
      // 如果在栈顶且参数相同,则不做任何动作,否则重建页面
      bool isTopOfStack = _activePages.last == inStack;
      if (isTopOfStack && inStack.settings == runRes.settings) {
        rebuildStack = false;
      } else {
        _activePages.remove(inStack);
        _activePages.add(runRes);
      }
    } else {
      _activePages.add(runRes);
    }
    if (rebuildStack) notifyListeners();
    return decoder.completer?.future as Future<T?>?;
  }

  /// 跳转404页面
  @protected
  Future<void> _toUnknownPage([bool clearPages = false]) async {
    if (clearPages) _activePages.clear();
    final decoder = _getRouteDecoder(unknownPage.name);
    _push(decoder!);
  }

  @protected
  void _popWithResult<T>([T? result]) {
    final completer = _activePages.removeLast().completer;
    if (completer != null && !completer.isCompleted) completer.complete(result);
  }

  @override
  Future<T?> pushNamed<T>(String name, {Object? arguments}) async {
    final decoder = _getRouteDecoder<T>(name, arguments);
    if (decoder != null) {
      return _push<T>(decoder);
    } else {
      _toUnknownPage();
    }
    return null;
  }

  @override
  Future<R?> pushReplacementNamed<T, R>(String name, {T? result, Object? arguments}) async {
    final decoder = _getRouteDecoder<T>(name, arguments);
    if (decoder == null) {
      _toUnknownPage();
      return null;
    }
    // 返回数据
    final completer = _activePages.lastWhereOrNull((e) => e.settings?.path == decoder.settings?.path)?.completer;
    if (completer != null && !completer.isCompleted) completer.complete(result);

    return _push<R>(decoder);
  }

  @override
  Future<T?> pushNamedAndRemoveUntil<T>(String name, PagePredicate predicate, {Object? arguments}) async {
    final decoder = _getRouteDecoder<T>(name, arguments);
    if (decoder == null) {
      _toUnknownPage();
      return null;
    }
    // 先压栈再清理中间的页面
    final result = _push<T>(decoder);
    var index = _activePages.length - 1;
    while (index >= 0 && !predicate.call(_activePages[index].page!)) {
      _activePages.removeAt(index);
      index--;
    }
    return result;
  }

  bool canPop() => _activePages.length > 1;

  void _checkIfCanPop() {
    assert(() {
      if (!canPop()) {
        final name = _activePages.last.page?.name;
        throw 'The page [$name] can not be popped!';
      }
      return true;
    }());
  }

  @override
  void pop<T>([T? result]) {
    _checkIfCanPop();
    _popWithResult<T>(result);
    notifyListeners();
  }

  @override
  void popUntil(PagePredicate predicate) {
    while (canPop() && !predicate.call(_activePages.last.page!)) {
      _popWithResult();
    }
    notifyListeners();
  }

  @override
  Future<R?> popAndPushNamed<T, R>(String name, {T? result, Object? arguments}) async {
    final decoder = _getRouteDecoder<R>(name, arguments);
    if (decoder == null) return null;
    _popWithResult<T>(result);
    return _push<R>(decoder);
  }

  @override
  void removeRoute(PagePredicate predicate) {
    _activePages.removeWhere((e) => predicate.call(e.page!));
  }

  @override
  void removeRouteBelow(PagePredicate predicate) {
    // 路由在栈中都是唯一的, indexWhere和lastIndexWhere效果相同
    final index = _activePages.lastIndexWhere((e) => predicate.call(e.page!));
    if (index > 0) _activePages.removeRange(0, index);
  }
}
