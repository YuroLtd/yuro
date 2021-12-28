import 'dart:ui' as ui;

import 'package:uuid/uuid.dart';
import 'package:yuro/yuro_core/yuro_core.dart';
import 'package:yuro/yuro_app/yuro_app.dart';

extension LocaleExt on String {
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

extension UUIDExt on String {
  String uuid5() => const Uuid().v5(Uuid.NAMESPACE_OID, this);

//todo 不全其它uuid方法
}

extension StringExt on String {
  int? toInt() => int.tryParse(this);

  bool isDigit() => int.tryParse(this) != null;

  double? toDouble() => double.tryParse(this);

  /// 判断字符串是否是手机号
  bool isPhone() => RegExp(r'^1(3|4|5|6|7|8|9)\d{9}$').hasMatch(this);

  /// 判断字符串是否是Url
  bool isUrl() =>
      RegExp(r'^((ht|f)tps?):\/\/[\w\-]+(\.[\w\-]+)+([\w\-\.,@?^=%&:\/~\+#]*[\w\-\@?^=%&\/~\+#])?$').hasMatch(this);
}

extension String2Ext on String? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  bool get isNullOrBlank => this == null || this!.trim().isEmpty;
}
