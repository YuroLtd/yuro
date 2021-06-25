import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:yuro/yuro_cache/yuro_cache.dart';
import 'package:yuro/yuro_core/yuro_core.dart';
import 'package:yuro/yuro_extension/yuro_extension.dart';
import 'package:yuro/yuro_route/yuro_route.dart';
import 'package:yuro/yuro_state/yuro_state.dart';
import 'package:yuro/yuro_translation/yuro_translation.dart';
import 'package:yuro/yuro_upgrade/yuro_upgrade.dart';
import 'package:yuro/yuro_widget/yuro_widget.dart';

import 'yuro_app_controller.dart';

class YuroMaterialApp extends StatefulWidget {
  YuroMaterialApp({
    this.appId,
    this.upgradeUrl,
    this.designSize = const Size(360, 640),
    //
    required this.title,
    this.onGenerateTitle,
    this.color,
    this.builder,
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
  });

  /// 用于应用更新、埋点上报、崩溃上报的标识
  final String? appId;
  final String? upgradeUrl;

  /// ui设计尺寸,以dp为单位
  final Size designSize;

  final String title;
  final GenerateAppTitle? onGenerateTitle;
  final Color? color;
  final TransitionBuilder? builder;

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
  _YuroMaterialAppState createState() => _YuroMaterialAppState();
}

class _YuroMaterialAppState extends State<YuroMaterialApp> {
  @override
  void initState() {
    super.initState();
    // 设置应用标识
    Yuro.appId = widget.appId;
    // 注入UI设计图尺寸
    Yuro.uiSize(widget.designSize.width, widget.designSize.height);

    Yuro.navigatorKey = widget.navigatorKey ?? GlobalKey<NavigatorState>();

    // 注入备选语言和翻译
    Yuro.fallbackLocale = widget.fallbackLocale;
    Yuro.addTranslations(widget.translations);

    SchedulerBinding.instance?.addPostFrameCallback(lazyLoad);
  }

  void lazyLoad(Duration duration) async {
    // 加载应用信息
    await Yuro.loadPackageInfo();
    // 初始化缓存
    await Yuro.openCache();

    //加载Locale
    var localeCache = await Yuro.getString(KEY_LOCALE);
    if (localeCache != null) {
      var config = localeCache.split('_');
      var locale = Locale(config[0], config.length == 2 ? config[1] : null);
      Yuro.changeLocale(locale);
    }
    //加载ThemeMode
    var themeModeIndex = await Yuro.getInt(KEY_THEME_MODE);
    if (themeModeIndex != null) {
      Yuro.changeThemeMode(ThemeMode.values[themeModeIndex]);
    }
  }

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (_) => YuroAppController(),
      builder: (context, child) => MaterialApp(
            key: context.watch<YuroAppController>().key,
            title: widget.title,
            onGenerateTitle: widget.onGenerateTitle,
            color: widget.color,
            builder: (context, child) => DismissKeyBoard(child: widget.builder?.call(context, child) ?? child),
            //
            navigatorKey: Yuro.navigatorKey,
            navigatorObservers: [...widget.navigatorObservers],

            // 主题部分
            theme: widget.theme,
            darkTheme: widget.darkTheme,
            highContrastTheme: widget.highContrastTheme,
            highContrastDarkTheme: widget.highContrastDarkTheme,
            themeMode: context.watch<YuroAppController>().themeMode,

            //
            initialRoute: widget.routes.initialRoute,
            onGenerateRoute: widget.routes.onGenerateRoute,
            onUnknownRoute: widget.routes.onUnknownRoute,

            // 语言
            locale: context.watch<YuroAppController>().locale,
            supportedLocales: widget.supportedLocales ?? const <Locale>[Locale('zh', 'CN')],
            localizationsDelegates: widget.localizationsDelegates ??
                const [
                  GlobalWidgetsLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
            localeListResolutionCallback: widget.localeListResolutionCallback,
            localeResolutionCallback: widget.localeResolutionCallback,
            //
            debugShowCheckedModeBanner: widget.debugShowCheckedModeBanner,
            debugShowMaterialGrid: widget.debugShowMaterialGrid,
            showPerformanceOverlay: widget.showPerformanceOverlay,
            checkerboardRasterCacheImages: widget.checkerboardRasterCacheImages,
            checkerboardOffscreenLayers: widget.checkerboardOffscreenLayers,
            showSemanticsDebugger: widget.showSemanticsDebugger,
            shortcuts: widget.shortcuts,
            actions: widget.actions,
          ));
}
