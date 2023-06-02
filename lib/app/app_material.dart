import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:yuro/app/viewmodel/material.dart';

import 'app.dart';

class YuroMaterialApp extends YuroApp {
  const YuroMaterialApp({
    super.key,
    //
    this.scaffoldMessengerKey,
    super.title,
    super.onGenerateTitle,
    super.color,
    super.builder,
    //
    required super.routes,
    super.observers,
    super.navigatorKey,
    super.initialLocation,
    super.initialExtra,
    super.refreshListenable,
    super.redirectLimit,
    super.routerNeglect,
    super.redirect,
    super.errorPageBuilder,
    super.errorBuilder,
    //
    super.locale,
    required super.localizationsDelegates,
    super.localeListResolutionCallback,
    super.localeResolutionCallback,
    required super.supportedLocales,
    //
    super.debugShowMaterialGrid,
    super.showPerformanceOverlay,
    super.checkerboardRasterCacheImages,
    super.checkerboardOffscreenLayers,
    super.showSemanticsDebugger,
    super.debugShowCheckedModeBanner,
    super.shortcuts,
    super.actions,
    super.restorationScopeId,
    super.scrollBehavior,
  });

  final GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey;

  // ThemeData? theme,
  // ThemeData? darkTheme,
  // ThemeData? highContrastTheme,
  // ThemeData? highContrastDarkTheme,
  // ThemeMode? themeMode = ThemeMode.system,
  // Duration themeAnimationDuration = kThemeAnimationDuration,
  // Curve themeAnimationCurve = Curves.linear,

  @override
  Widget build(BuildContext context) => Provider(create: (_) => MaterialViewModel(), builder: (context, child) => buildApp(context));

  @override
  Widget buildApp(BuildContext context) => MaterialApp.router(
        key: context.select<MaterialViewModel, UniqueKey?>((value) => value.appKey),
        scaffoldMessengerKey: scaffoldMessengerKey,
        //
        routerConfig: buildRouter(),
        //
        builder: transitionBuilder,
        title: title ?? '',
        onGenerateTitle: onGenerateTitle,
        color: color,
        //
        // theme: ,
        // darkTheme: ,
        // highContrastTheme:,
        // highContrastDarkTheme: ,
        // themeMode: ,
        // themeAnimationDuration:
        // themeAnimationCurve:
        //
        locale: locale,
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
        scrollBehavior: scrollBehavior,
      );
}
