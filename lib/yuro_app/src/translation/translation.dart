import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:yuro/yuro_core/yuro_core.dart';
import 'package:yuro/yuro_app/yuro_app.dart' show YuroAppControllerExt;

export 'package:flutter_localizations/flutter_localizations.dart';

const List<String> RtlLanguages = <String>['ar', 'fa', 'he', 'ps', 'ur'];

class _Translation {
  late Locale fallbackLocale;
  Map<String, Map<String, String>> translations = {};
}

extension YuroTranslationExt on YuroInterface {
  static _Translation _translation = _Translation();

  Locale get fallbackLocale => _translation.fallbackLocale;

  set fallbackLocale(Locale locale) => _translation.fallbackLocale = locale;

  Map<String, Map<String, String>> get translations => _translation.translations;

  void addTranslations(Map<String, Map<String, String>> translations) {
    _translation.translations.addAll(translations);
  }
}

extension TranslationExt on String {
  String get tr {
    // 从主语言中查询
    final locale = Yuro.locale ?? ui.window.locale;
    if (_hitTest('${locale.languageCode}_${locale.countryCode}', this)) {
      return Yuro.translations['${locale.languageCode}_${locale.countryCode}']![this]!;
    } else if (_hitTest('${locale.languageCode}', this)) {
      return Yuro.translations['${locale.languageCode}']![this]!;
    }
    // 从备用语言中查询
    final fallbackLocale = Yuro.fallbackLocale;
    if (_hitTest('${fallbackLocale.languageCode}_${fallbackLocale.countryCode}', this)) {
      return Yuro.translations['${fallbackLocale.languageCode}_${fallbackLocale.countryCode}']![this]!;
    } else if (_hitTest('${fallbackLocale.languageCode}', this)) {
      return Yuro.translations['${fallbackLocale.languageCode}']![this]!;
    }
    return this;
  }

  bool _hitTest(String localeStr, String key) {
    return Yuro.translations.containsKey(localeStr) && (Yuro.translations[localeStr]?.containsKey(key) ?? false);
  }
}
