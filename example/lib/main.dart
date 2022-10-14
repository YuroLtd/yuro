import 'package:flutter/material.dart';
import 'package:example/export.dart';

Future<void> _init() async {
  // Yuro.logLevel = LogLevel.verbose;
  // final intBox = await Yuro.openHiveBox<int>();
  //
  // final colorIndex = intBox.get(kThemeColor) ?? 0;
  // Yuro.app.theme = defaultColorScheme[colorIndex];
  // Yuro.app.darkTheme = defaultDarkColorScheme[colorIndex];
  //
  // final themeMode = ThemeMode.values[intBox.get(kThemeMode) ?? ThemeMode.system.index];
  // Yuro.app.themeMode = themeMode;
  //
  // final stringBox = await Yuro.openHiveBox<String>();
  // final localeStr = stringBox.get(kLocale);
  // if (localeStr.notNull) {
  //   final array = localeStr!.split('-');
  //   Yuro.app.locale = Locale(array[0], array.length == 2 ? array[1] : null);
  // }
}

void run() => runYuroApp(
    onInit: () {},
    builder: () => YuroApp(
          pages: AppRoutes.pages,
          initialRoute: AppRouteKeys.root,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ));
