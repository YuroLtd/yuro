import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yuro/yuro_core/yuro_core.dart';
import 'package:yuro/yuro_route/yuro_route.dart';

import 'yuro_app.dart';
import 'app_config.dart';

extension YuroAppExt on YuroInterface {
  YuroAppController get _appController => currentContext.read<YuroAppController>();

  // theme mode
  ThemeMode get themeMode => _appController.themeMode;

  void changeThemeMode(ThemeMode newThemeMode) => _appController.themeMode = newThemeMode;

  //
  ThemeData get theme => Theme.of(Yuro.currentContext);

  TextTheme get textTheme => theme.textTheme;

  // locale
  Locale? get locale => _appController.locale;

  void changeLocale(Locale? locale) => _appController.locale = locale;

  // fallback locale
  Locale get fallbackLocale => _appController.fallbackLocale;

  /// 获取国际化翻译对照表
  Map<String, Map<String, String>> get translations => _appController.translations;

  /// 获取应用配置
  AppConfig get appConfig => currentContext.read<AppConfig>();

  /// 应用重新载入
  void reload() => _appController.reload();
}
