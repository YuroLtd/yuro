library yuro_intl;

import 'package:flutter/material.dart';
import 'package:yuro/yuro_app/yuro_app.dart';
import 'package:yuro/yuro_cache/yuro_cache.dart';
import 'package:yuro/yuro_core/yuro_core.dart';

export 'package:flutter_localizations/flutter_localizations.dart';

export 'src/intl_ext.dart';

const List<String> RtlLanguages = <String>['ar', 'fa', 'he', 'ps', 'ur'];

extension YuroTranslationExt on YuroInterface {
  /// 首选语言
  static Locale? _locale;

  Locale? get locale => _locale;

  set locale(Locale? locale) {
    if (_locale == locale) return;
    _locale = locale;
    Yuro.sp.setString(KEY_LOCALE, '${_locale?.languageCode}_${_locale?.countryCode}');
    Yuro.reload();
  }

  /// 备用语言
  static Locale _fallbackLocale = const Locale('en', 'US');

  Locale get fallbackLocale => _fallbackLocale;

  set fallbackLocale(Locale locale) => _fallbackLocale = locale;

  /// 国际化翻译对照表
  static Map<String, Map<String, String>> _translations = {};

  Map<String, Map<String, String>> get translations => _translations;

  void addTranslations(Map<String, Map<String, String>> translations) => _translations.addAll(translations);
}
