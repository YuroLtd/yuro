import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:yuro/core/core.dart';
import 'package:yuro/router/router.dart';
import 'package:yuro/state/state.dart';
import 'package:yuro/widget/widget.dart';

part 'app_controller.dart';

class YuroApp extends StatelessWidget {
  /// 如果使用国际化中的title,需使用[onGenerateTitle],
  final String title;
  final GenerateAppTitle? onGenerateTitle;
  final Color? color;
  final TransitionBuilder? transitionBuilder;
  final GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey;
  final PageTransitionsBuilder? globalTransition;
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

  /// 组件覆盖不完全,不推荐使用
  final bool useMaterial3;
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
    //
    this.title = '',
    this.onGenerateTitle,
    this.color,
    this.transitionBuilder,
    this.scaffoldMessengerKey,
    this.globalTransition,
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
    this.useMaterial3 = false,
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
  Widget build(BuildContext context) => YuroBuilder<YuroAppController>(init: Yuro.app, builder: (_) => builder(_));

  Widget builder(YuroAppController controller) {
    controller.globalTransition = globalTransition;
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
      theme: ThemeData(
        colorScheme: controller.theme ?? const ColorScheme.light(),
        useMaterial3: useMaterial3,
      ),
      darkTheme: ThemeData(
        colorScheme: controller.darkTheme ?? const ColorScheme.dark(),
        useMaterial3: useMaterial3,
      ),
      highContrastTheme: ThemeData(
        colorScheme: controller.highContrastTheme ?? const ColorScheme.highContrastLight(),
        useMaterial3: useMaterial3,
      ),
      highContrastDarkTheme: ThemeData(
        colorScheme: controller.highContrastDarkTheme ?? const ColorScheme.highContrastLight(),
        useMaterial3: useMaterial3,
      ),
      themeMode: controller.themeMode,
      //
      locale: controller.locale,
      localizationsDelegates: [
        ...localizationsDelegates,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
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
