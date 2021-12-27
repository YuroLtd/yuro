import 'package:flutter/material.dart';
import 'package:yuro_plugin/yuro_plugin.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:yuro/yuro_cache/yuro_cache.dart';
import 'package:yuro/yuro_core/yuro_core.dart';
import 'package:yuro/yuro_route/yuro_route.dart';
import 'package:yuro/yuro_state/yuro_state.dart';
import 'package:yuro/yuro_widget/yuro_widget.dart';
import 'package:yuro/yuro_analysis/crashlytics/crashlytics.dart';

part 'yuro_app.g.dart';

class YuroApp extends YuroView<YuroAppController> {
  YuroApp({
    Key? key,
    //
    required this.title,
    this.onGenerateTitle,
    this.color,
    this.transitionBuilder,
    //
    this.navigatorKey,
    this.navigatorObservers = const [],
    //
    this.theme,
    this.darkTheme,
    this.highContrastTheme,
    this.highContrastDarkTheme,
    //
    required this.routes,

    //
    this.fallbackLocale = const Locale('en', 'US'),
    this.translations = const {},
    this.localizationsDelegates,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.supportedLocales,
    //
    this.debugShowCheckedModeBanner = true,
    this.debugShowMaterialGrid = false,
    this.showPerformanceOverlay = false,
    this.checkerboardRasterCacheImages = false,
    this.checkerboardOffscreenLayers = false,
    this.showSemanticsDebugger = false,
    this.shortcuts,
    this.actions,
  }) : super(key: key) {
    if (navigatorKey != null) {
      Yuro.navigatorKey = navigatorKey!;
    }
  }

  final String title;
  final GenerateAppTitle? onGenerateTitle;
  final Color? color;
  final TransitionBuilder? transitionBuilder;

  final GlobalKey<NavigatorState>? navigatorKey;
  final List<NavigatorObserver> navigatorObservers;

  //
  final ThemeData? theme;
  final ThemeData? darkTheme;
  final ThemeData? highContrastTheme;
  final ThemeData? highContrastDarkTheme;

  //
  final YuroRoute routes;

  //
  final Locale fallbackLocale;
  final Map<String, Map<String, String>> translations;

  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;
  final LocaleListResolutionCallback? localeListResolutionCallback;
  final LocaleResolutionCallback? localeResolutionCallback;
  final Iterable<Locale>? supportedLocales;

  //
  final bool debugShowMaterialGrid;
  final bool showPerformanceOverlay;
  final bool checkerboardRasterCacheImages;
  final bool checkerboardOffscreenLayers;
  final bool showSemanticsDebugger;
  final bool debugShowCheckedModeBanner;

  //
  final Map<LogicalKeySet, Intent>? shortcuts;
  final Map<Type, Action<Intent>>? actions;

  @override
  YuroAppController createController() => YuroAppController(fallbackLocale, translations);

  @override
  Widget builder(context, controller) => Obs<UniqueKey>(
      valueListenable: controller._uniqueKey,
      builder: (context, value, child) => MaterialApp(
            key: value,
            title: title,
            onGenerateTitle: onGenerateTitle,
            color: color,
            builder: (context, child) => DismissKeyBoard(child: transitionBuilder?.call(context, child) ?? child),
            //
            navigatorKey: Yuro.navigatorKey,
            navigatorObservers: [YuroNavigatorObserver(), ...navigatorObservers],

            // 主题部分
            theme: theme,
            darkTheme: darkTheme,
            highContrastTheme: highContrastTheme,
            highContrastDarkTheme: highContrastDarkTheme,
            themeMode: controller.themeMode,

            //
            initialRoute: routes.initialRoute,
            onGenerateRoute: routes.onGenerateRoute,
            onUnknownRoute: routes.onUnknownRoute,

            // 语言
            locale: controller.locale,
            supportedLocales: supportedLocales ?? const <Locale>[Locale('zh', 'CN')],
            localizationsDelegates: localizationsDelegates ??
                const [
                  GlobalWidgetsLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
            localeListResolutionCallback: localeListResolutionCallback,
            localeResolutionCallback: localeResolutionCallback,
            //
            debugShowCheckedModeBanner: debugShowCheckedModeBanner,
            debugShowMaterialGrid: debugShowMaterialGrid,
            showPerformanceOverlay: showPerformanceOverlay,
            checkerboardRasterCacheImages: checkerboardRasterCacheImages,
            checkerboardOffscreenLayers: checkerboardOffscreenLayers,
            showSemanticsDebugger: showSemanticsDebugger,
            shortcuts: shortcuts,
            actions: actions,
          ));
}
