import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:yuro/core/interface.dart';

import 'app.dart';
import 'app_viewmodel.dart';

class YuroCupertinoApp extends YuroApp {
  const YuroCupertinoApp({
    super.key,
    //
    super.title,
    super.onGenerateTitle,
    super.color,
    super.builder,
    //
    this.theme,
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

  final CupertinoThemeData? theme;

  @override
  Widget build(BuildContext context) => Provider(
        create: (context) => CupertinoViewModel(context),
        builder: (context, child) => buildApp(context),
      );

  @override
  Widget buildApp(BuildContext context) => CupertinoApp.router(
        key: context.select<CupertinoViewModel, UniqueKey?>((value) => value.appKey),
        //
        routerConfig: Yuro.router,
        theme: context.select<CupertinoViewModel, CupertinoThemeData?>((value) => value.theme),
        //
        builder: transitionBuilder,
        title: title ?? '',
        onGenerateTitle: onGenerateTitle,
        color: color,
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
        //
        showPerformanceOverlay: showPerformanceOverlay,
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
