import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:yuro/yuro_core/yuro_core.dart';
import 'package:yuro/yuro_cache/yuro_cache.dart';
import 'package:yuro/yuro_route/yuro_route.dart';

import 'yuro_app.dart';

const String KEY_LOCALE = 'key_locale';
const String KEY_THEME_MODE = 'key_theme_mode';

extension YuroAppExt on YuroInterface {
  static ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  set themeMode(ThemeMode newThemeMode) {
    if (themeMode == newThemeMode) return;
    _themeMode = newThemeMode;
    Yuro.sp.setInt(KEY_THEME_MODE, newThemeMode.index);
    reload();
  }

  ThemeData get theme => Theme.of(Yuro.currentContext);

  TextTheme get textTheme => theme.textTheme;

  /// 应用重新加载
  void reload() => Yuro.currentContext.read<YuroAppController>().reload();
}
