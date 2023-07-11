import 'package:flutter/material.dart';

abstract class YuroApp extends StatelessWidget {
  const YuroApp({
    super.key,
    //
    this.title,
    this.onGenerateTitle,
    this.color,
    this.builder,
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

  /// 构建App
  Widget buildApp(BuildContext context);

  // 点击空白处隐藏软键盘
  Widget transitionBuilder(BuildContext context, Widget? child) => GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: builder?.call(context, child) ?? child,
      );
}
