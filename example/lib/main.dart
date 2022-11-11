import 'package:flutter/material.dart';
import 'package:example/export.dart';
import 'package:flutter/services.dart';

void run() => runYuroApp(
    onInit: () {
      Yuro.app.themeMode = ThemeMode.values[Yuro.sp.getInt(kThemeMode) ?? ThemeMode.system.index];
      final seedColor = defaultThemeColors[Yuro.sp.getInt(kThemeIndex) ?? 0];
      Yuro.app.theme = ColorScheme.fromSeed(seedColor: seedColor);
      Yuro.app.darkTheme = ColorScheme.fromSeed(seedColor: seedColor, brightness: Brightness.dark);

      final locale = Yuro.sp.getString(kLocale);
      if (locale != null) {
        final array = locale.split('-');
        Yuro.app.locale = Locale.fromSubtags(languageCode: array[0], countryCode: array.length == 2 ? array[1] : null);
      }
    },
    onFlutterError: CrashHandler.get().handlerError,
    onPlatformError: CrashHandler.get().handlerPlatformError,
    systemUiOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    builder: () => YuroApp(
          pages: AppRoutes.pages,
          initialRoute: AppRouteKeys.root,
          localizationsDelegates: const [S.delegate],
          supportedLocales: S.delegate.supportedLocales,
          localeResolutionCallback: (locale, supportedLocales) {
            // 如果未配置locale或locale不在支持列表中,使用支持列表的首选语言
            return locale == null || !S.delegate.isSupported(locale) ? supportedLocales.first : locale;
          },
          useMaterial3: true,
        ));
