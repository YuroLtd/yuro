import 'package:flutter/material.dart';
import 'package:example/export.dart';

void run() => runYuroApp(
    onInit: _init,
    app: YuroApp(
      pages: AppRoutes.pages,
      initialRoute: AppRouteKeys.root,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    ));

Future<void> _init() async {
  Yuro.logLevel = LogLevel.verbose;
  final intBox = await Yuro.openHiveBox<int>();

  final colorIndex = intBox.get(kThemeColor) ?? 0;
  Yuro.app.theme = defaultColorScheme[colorIndex];
  Yuro.app.darkTheme = defaultDarkColorScheme[colorIndex];

  final themeMode = ThemeMode.values[intBox.get(kThemeMode) ?? ThemeMode.system.index];
  Yuro.app.themeMode = themeMode;
}
