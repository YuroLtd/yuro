import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:yuro/core/core.dart';
import 'package:yuro/router/router.dart';
import 'package:yuro/state/src/binder/binder.dart';
import 'package:yuro/state/state.dart';
import 'package:yuro/util/src/screen.dart';
import 'package:yuro/widget/widget.dart';

part 'app_controller.dart';

class YuroApp extends StatelessWidget {
  final Size? uiSize;

  /// 如果使用国际化中的title,需使用[onGenerateTitle],
  final String title;
  final GenerateAppTitle? onGenerateTitle;
  final Color? color;
  final TransitionBuilder? builder;
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

  final bool debugShowMaterialGrid;
  final bool showPerformanceOverlay;
  final bool checkerboardRasterCacheImages;
  final bool checkerboardOffscreenLayers;
  final bool showSemanticsDebugger;
  final bool debugShowCheckedModeBanner;
  final Map<LogicalKeySet, Intent>? shortcuts;
  final Map<Type, Action<Intent>>? actions;
  final String? restorationScopeId;

  YuroApp({
    super.key,
    this.uiSize,
    //
    this.title = '',
    this.onGenerateTitle,
    this.color,
    this.builder,
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
    this.debugShowMaterialGrid = false,
    this.showPerformanceOverlay = false,
    this.checkerboardRasterCacheImages = false,
    this.checkerboardOffscreenLayers = false,
    this.showSemanticsDebugger = false,
    this.debugShowCheckedModeBanner = true,
    this.shortcuts,
    this.actions,
    this.restorationScopeId,
  })  : assert(pages.isNotEmpty),
        assert(supportedLocales.isNotEmpty);

  @override
  Widget build(BuildContext context) {
    Yuro.app.globalTransition = globalTransition;
    final routerDelegate = Yuro.createRouterDelegate(
      pages: pages,
      unknownPage: unknownPage,
      navigatorKey: navigatorKey,
      navigatorObservers: navigatorObservers,
    );
    final routerParser = Yuro.createRouteParser(initialRoute);

    return Binder<YuroAppController>(
        init: () => Yuro.app,
        child: MaterialApp.router(
          key: Yuro.app.uniqueKey,
          scaffoldMessengerKey: scaffoldMessengerKey,
          //
          routeInformationProvider: routeInformationProvider,
          routeInformationParser: routerParser,
          routerDelegate: routerDelegate,
          backButtonDispatcher: backButtonDispatcher,
          //
          builder: (context, child) {
            Yuro.initScreen(MediaQuery.of(context), uiSize);
            return DismissKeyBoard(child: builder?.call(context, child) ?? child);
          },
          title: title,
          onGenerateTitle: onGenerateTitle,
          color: color,
          //
          theme: Yuro.app.lightTheme,
          darkTheme: Yuro.app.darkTheme,
          highContrastTheme: Yuro.app.highContrastTheme,
          highContrastDarkTheme: Yuro.app.highContrastDarkTheme,
          themeMode: Yuro.app.themeMode,
          //
          locale: Yuro.app.locale,
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
        ));
  }
}
