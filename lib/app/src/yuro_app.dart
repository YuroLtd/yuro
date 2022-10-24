import 'dart:core';

import 'package:flutter/material.dart';

import 'package:yuro/core/core.dart';
import 'package:yuro/router/router.dart';
import 'package:yuro/state/state.dart';
import 'package:yuro/widget/widget.dart';

part 'app_controller.dart';

class YuroApp extends StatelessWidget {
  final VoidCallback? onReady, onDispose;

  /// 如果使用国际化中的title,需使用[onGenerateTitle],
  final String title;
  final GenerateAppTitle? onGenerateTitle;
  final Color? color;
  final TransitionBuilder? transitionBuilder;
  final GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey;

  //
  final String initialRoute;
  final List<YuroPage> pages;
  final YuroPage? unknownPage;
  final GlobalKey<NavigatorState>? navigatorKey;
  final List<NavigatorObserver>? navigatorObservers;
  final RouteInformationProvider? routeInformationProvider;
  final BackButtonDispatcher? backButtonDispatcher;

  //
  final Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates;
  final LocaleListResolutionCallback? localeListResolutionCallback;
  final LocaleResolutionCallback? localeResolutionCallback;
  final Iterable<Locale> supportedLocales;

  //
  final bool debugShowMaterialGrid;
  final bool showPerformanceOverlay;
  final bool checkerboardRasterCacheImages;
  final bool checkerboardOffscreenLayers;
  final bool showSemanticsDebugger;
  final bool debugShowCheckedModeBanner;
  final Map<LogicalKeySet, Intent>? shortcuts;
  final Map<Type, Action<Intent>>? actions;
  final String? restorationScopeId;
  final bool useInheritedMediaQuery;

  YuroApp({
    super.key,
    this.onReady,
    this.onDispose,
    //
    this.title = '',
    this.onGenerateTitle,
    this.color,
    this.transitionBuilder,
    this.scaffoldMessengerKey,
    //
    required this.initialRoute,
    required this.pages,
    this.unknownPage,
    this.navigatorKey,
    this.navigatorObservers,
    this.routeInformationProvider,
    this.backButtonDispatcher,
    //
    this.localizationsDelegates = const [],
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.supportedLocales = const [],
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
    this.useInheritedMediaQuery = false,
  })  : assert(pages.isNotEmpty),
        assert(supportedLocales.isNotEmpty);

  @override
  Widget build(BuildContext context) => YuroBuilder<YuroAppController>(
      init: Yuro.app,
      initState: () {
        // 插件初始化完成后
        Yuro.engine.addPostFrameCallback((timeStamp) {
          onReady?.call();
        });
      },
      dispose: onDispose,
      builder: (_) => builder(_));

  Widget builder(YuroAppController controller) {
    final routerDelegate = Yuro.createRouterDelegate(
      pages: pages,
      unknownPage: unknownPage,
      navigatorKey: navigatorKey,
      navigatorObservers: navigatorObservers,
    );
    final routerParser = Yuro.createRouteParser(initialRoute);
    return MaterialApp.router(
      key: controller.uniqueKey,
      scaffoldMessengerKey: scaffoldMessengerKey,
      //
      routeInformationProvider: routeInformationProvider,
      routeInformationParser: routerParser,
      routerDelegate: routerDelegate,
      backButtonDispatcher: backButtonDispatcher,
      //
      builder: (context, child) => DismissKeyBoard(child: transitionBuilder?.call(context, child) ?? child),
      title: title,
      onGenerateTitle: onGenerateTitle,
      color: color,
      //
      theme: ThemeData(colorScheme: controller.theme),
      darkTheme: ThemeData(colorScheme: controller.darkTheme),
      highContrastTheme: ThemeData(colorScheme: controller.highContrastTheme),
      highContrastDarkTheme: ThemeData(colorScheme: controller.highContrastDarkTheme),
      themeMode: controller.themeMode,
      //
      locale: controller.locale,
      localizationsDelegates: localizationsDelegates,
      localeResolutionCallback: localeResolutionCallback,
      localeListResolutionCallback: localeListResolutionCallback,
      supportedLocales: supportedLocales,
      //
      showPerformanceOverlay: showPerformanceOverlay,
      debugShowMaterialGrid: debugShowMaterialGrid,
      checkerboardRasterCacheImages: checkerboardRasterCacheImages,
      checkerboardOffscreenLayers: checkerboardOffscreenLayers,
      showSemanticsDebugger: showSemanticsDebugger,
      debugShowCheckedModeBanner: debugShowCheckedModeBanner,
      shortcuts: shortcuts,
      actions: actions,
      restorationScopeId: restorationScopeId,
      useInheritedMediaQuery: useInheritedMediaQuery,
    );
  }
}
