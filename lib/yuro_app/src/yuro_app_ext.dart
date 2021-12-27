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

  /// 获取应用名称
  String get appName => _appController.appInfo.appName;

  /// 获取应用包名
  String get packageName => _appController.appInfo.packageName;

  /// 获取应用版本
  String get versionName => _appController.appInfo.versionName;

  /// 获取应用数字版本号
  int get versionCode => _appController.appInfo.versionCode;

  /// 获取androidId
  String? get androidId => _appController.appInfo.androidId;

  /// 获取userAgent
  String get userAgent => _appController.appInfo.userAgent;

  /// 应用重新载入
  void reload() => _appController.reload();
}
