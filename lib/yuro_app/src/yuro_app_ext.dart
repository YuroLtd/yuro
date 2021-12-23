import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:yuro/yuro_core/yuro_core.dart';
import 'package:yuro/yuro_cache/yuro_cache.dart';
import 'package:yuro_plugin/yuro_plugin.dart';

import '../yuro_app.dart';

extension YuroAppExt on YuroInterface {
  // 主题模式
  static ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  set themeMode(ThemeMode newThemeMode) {
    if (themeMode == newThemeMode) return;
    _themeMode = newThemeMode;
    Yuro.sp.setInt(KEY_THEME_MODE, newThemeMode.index);
    reload();
  }

  // 首选语言
  static Locale? _locale;

  Locale? get locale => _locale;

  set locale(Locale? locale) {
    if (_locale == locale) return;
    _locale = locale;
    Yuro.sp.setString(KEY_LOCALE, '${_locale?.languageCode}_${_locale?.countryCode}');
    reload();
  }

  // 备用语言
  static Locale _fallbackLocale = const Locale('en', 'US');

  Locale get fallbackLocale => _fallbackLocale;

  set fallbackLocale(Locale locale) => _fallbackLocale = locale;

  // 国际化翻译对照表
  static final Map<String, Map<String, String>> _translations = {};

  Map<String, Map<String, String>> get translations => _translations;

  void addTranslations(Map<String, Map<String, String>> translations) => _translations.addAll(translations);

  // 导航
  static GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  set navigatorKey(GlobalKey<NavigatorState> navigatorKey) => _navigatorKey = navigatorKey;

  BuildContext get currentContext => navigatorKey.currentContext!;

  NavigatorState get currentState => navigatorKey.currentState!;

  //
  ThemeData get theme => Theme.of(Yuro.currentContext);

  //
  TextTheme get textTheme => theme.textTheme;

  //
  Screen get screen => Screen.instance;

  //
  void reload() => currentContext.read<YuroAppController>().reload();

  static late AppInfo _appInfo;

  /// 加载应用信息
  Future<void> loadAppInfo() async => _appInfo = await YuroPlugin().app.appInfo();

  /// 获取应用名称
  String get appName => _appInfo.appName;

  /// 获取应用包名
  String get packageName => _appInfo.packageName;

  /// 获取应用版本
  String get versionName => _appInfo.versionName;

  /// 获取应用数字版本号
  int get versionCode => _appInfo.versionCode;

  /// 获取androidId
  String? get androidId => _appInfo.androidId;

  /// 获取userAgent
  String get userAgent => _appInfo.userAgent;
}
