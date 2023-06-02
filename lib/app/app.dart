import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yuro/core/interface.dart';

abstract class YuroApp extends StatelessWidget {
  const YuroApp({
    super.key,
    //
    this.title,
    this.onGenerateTitle,
    this.color,
    this.builder,
    //
    required this.routes,
    this.observers,
    this.navigatorKey,
    this.initialLocation,
    this.initialExtra,
    this.refreshListenable,
    this.redirectLimit = 5,
    this.routerNeglect = false,
    this.redirect,
    this.errorPageBuilder,
    this.errorBuilder,
    //
    this.locale,
    required this.localizationsDelegates,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    required this.supportedLocales,
    //
    this.debugShowMaterialGrid = false,
    this.showPerformanceOverlay = false,
    this.checkerboardRasterCacheImages = false,
    this.checkerboardOffscreenLayers = false,
    this.showSemanticsDebugger = false,
    this.debugShowCheckedModeBanner = true,
    this.shortcuts,
    this.actions,
    this.restorationScopeId,
    this.scrollBehavior,
  });

  final String? title;
  final GenerateAppTitle? onGenerateTitle;
  final Color? color;
  final TransitionBuilder? builder;

  final List<RouteBase> routes;
  final List<NavigatorObserver>? observers;
  final GlobalKey<NavigatorState>? navigatorKey;
  final String? initialLocation;
  final Object? initialExtra;
  final Listenable? refreshListenable;
  final int redirectLimit;
  final bool routerNeglect;
  final GoRouterRedirect? redirect;
  final GoRouterPageBuilder? errorPageBuilder;
  final GoRouterWidgetBuilder? errorBuilder;

  final Locale? locale;
  final Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates;
  final LocaleListResolutionCallback? localeListResolutionCallback;
  final LocaleResolutionCallback? localeResolutionCallback;
  final Iterable<Locale> supportedLocales;

  final bool debugShowMaterialGrid;
  final bool showPerformanceOverlay;
  final bool checkerboardRasterCacheImages;
  final bool checkerboardOffscreenLayers;
  final bool showSemanticsDebugger;
  final bool debugShowCheckedModeBanner;
  final Map<LogicalKeySet, Intent>? shortcuts;
  final Map<Type, Action<Intent>>? actions;
  final String? restorationScopeId;
  final ScrollBehavior? scrollBehavior;


  /// 构造go_router
  GoRouter buildRouter() => Yuro.router = GoRouter(
        routes: routes,
        errorPageBuilder: errorPageBuilder,
        errorBuilder: errorBuilder,
        redirect: redirect,
        refreshListenable: refreshListenable,
        redirectLimit: redirectLimit,
        routerNeglect: routerNeglect,
        initialLocation: initialLocation,
        initialExtra: initialExtra,
        observers: observers,
        navigatorKey: navigatorKey,
        debugLogDiagnostics: kDebugMode,
        restorationScopeId: restorationScopeId,
      );

  /// 构建App
  Widget buildApp(BuildContext context);

  // 点击空白处隐藏软键盘
  Widget transitionBuilder(BuildContext context, Widget? child) => GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: builder?.call(context, child) ?? child,
      );
}

