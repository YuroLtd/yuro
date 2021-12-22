import 'dart:ui' as ui;

import 'package:yuro/yuro_core/yuro_core.dart';
import 'package:yuro/yuro_intl/yuro_intl.dart';

extension IntlExt on String {
  String get tr {
    // 从主语言中查询
    final locale = Yuro.locale ?? ui.window.locale;
    if (_hitTest('${locale.languageCode}_${locale.countryCode}', this)) {
      return Yuro.translations['${locale.languageCode}_${locale.countryCode}']![this]!;
    } else if (_hitTest(locale.languageCode, this)) {
      return Yuro.translations[locale.languageCode]![this]!;
    }
    // 从备用语言中查询
    final fallbackLocale = Yuro.fallbackLocale;
    if (_hitTest('${fallbackLocale.languageCode}_${fallbackLocale.countryCode}', this)) {
      return Yuro.translations['${fallbackLocale.languageCode}_${fallbackLocale.countryCode}']![this]!;
    } else if (_hitTest(fallbackLocale.languageCode, this)) {
      return Yuro.translations[fallbackLocale.languageCode]![this]!;
    }
    return this;
  }

  bool _hitTest(String localeStr, String key) {
    return Yuro.translations.containsKey(localeStr) && (Yuro.translations[localeStr]?.containsKey(key) ?? false);
  }
}