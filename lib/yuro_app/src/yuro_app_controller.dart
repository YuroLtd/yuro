import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

import 'package:yuro/yuro_core/yuro_core.dart';
import 'package:yuro/yuro_route/yuro_route.dart';
import 'package:yuro/yuro_state/yuro_state.dart';
import 'package:yuro/yuro_cache/yuro_cache.dart';

const String KEY_LOCALE = 'key_locale';
const String KEY_THEME_MODE = 'key_theme_mode';

class YuroAppController extends YuroController {
  Key _key = UniqueKey();

  Key get key => _key;

  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  set themeMode(ThemeMode newThemeMode) {
    if (themeMode == newThemeMode) return;
    _themeMode = newThemeMode;
    Yuro.setInt(KEY_THEME_MODE, newThemeMode.index);
    notifyListeners();
  }

  Locale? _locale;

  Locale? get locale => _locale;

  set locale(Locale? newLocale) {
    if (locale == newLocale) return;
    _locale = newLocale;
    Yuro.setString(KEY_LOCALE, '${_locale?.languageCode}_${_locale?.countryCode}');
    restart();
  }

  void restart() {
    _key = UniqueKey();
    notifyListeners();
  }
}

extension YuroAppControllerExt on YuroInterface {
  YuroAppController get _appController => Yuro.currentContext.read<YuroAppController>();

  void changeThemeMode(ThemeMode newThemeMode) => _appController.themeMode = newThemeMode;

  Locale? get locale => _appController.locale;

  void changeLocale(Locale? newLocale) => _appController.locale = newLocale;

  ThemeMode get themeMode => _appController.themeMode;

  ThemeData get theme => Theme.of(Yuro.currentContext);

  TextTheme get textTheme => theme.textTheme;

  void restart() => _appController.restart();


  static PackageInfo? _packageInfo;

  /// 加载应用信息
  Future<void> loadPackageInfo() async => _packageInfo = await PackageInfo.fromPlatform();

  /// 获取应用名称
  String? get appName => _packageInfo?.appName;

  /// 获取应用包名
  String? get appPackageName =>_packageInfo?.packageName;

  /// 获取应用版本
  String? get appVersionName => _packageInfo?.version;

  /// 获取应用数字版本号
  String? get appVersionCode => _packageInfo?.buildNumber;
}
