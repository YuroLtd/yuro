import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:yuro/core/interface.dart';

import 'app.dart';
import 'app_viewmodel.dart';

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
    super.locale,
    required super.localizationsDelegates,
    super.localeListResolutionCallback,
    super.localeResolutionCallback,
    required super.supportedLocales,
    //
    this.theme,
    this.darkTheme,
    this.highContrastTheme,
    this.highContrastDarkTheme,
    this.themeMode = ThemeMode.system,
    this.themeAnimationDuration = kThemeAnimationDuration,
    this.themeAnimationCurve = Curves.linear,
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

  final ThemeData? theme;
  final ThemeData? darkTheme;
  final ThemeData? highContrastTheme;
  final ThemeData? highContrastDarkTheme;
  final ThemeMode? themeMode;
  final Duration themeAnimationDuration;
  final Curve themeAnimationCurve;

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => MaterialViewModel(context),
        builder: (context, child) => buildApp(context),
      );

  @override
  Widget buildApp(BuildContext context) => MaterialApp.router(
        key: context.select<MaterialViewModel, UniqueKey?>((value) => value.appKey),
        scaffoldMessengerKey: scaffoldMessengerKey,
        //
        routerConfig: Yuro.router,
        //
        builder: transitionBuilder,
        title: title ?? '',
        onGenerateTitle: onGenerateTitle,
        color: color,
        //
        theme: theme,
        darkTheme: darkTheme,
        highContrastTheme: highContrastTheme,
        highContrastDarkTheme: highContrastDarkTheme,
        themeMode: themeMode,
        themeAnimationDuration: themeAnimationDuration,
        themeAnimationCurve: themeAnimationCurve,
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
