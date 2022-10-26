import 'package:example/export.dart';
import 'package:flutter/material.dart';

import 'package:example/generated/intl/messages_zh.dart' as zh;
import 'package:example/generated/intl/messages_zh_HK.dart' as hk;

class LocalizationSwitcher extends YuroWidget<YuroAppController> {
  const LocalizationSwitcher({super.key});

  String _locale(Locale locale) {
    switch (locale.toLanguageTag()) {
      case 'zh-HK':
        return hk.messages.messages['locale'].call();
      default:
        return zh.messages.messages['locale'].call();
    }
  }

  void _onLocaleChanged(Locale value) async {
    if (Yuro.sp.getString(kLocale) == value.toLanguageTag()) return;
    Yuro.sp.setString(kLocale, value.toLanguageTag());
    Yuro.app.locale = value;
    controller.reload();
  }

  @override
  Widget build(BuildContext context) => ExpansionTile(
      title: Text(S.of(context).language, style: const TextStyle(fontSize: 14)),
      trailing: Text(S.of(context).locale, style: const TextStyle(fontSize: 12)),
      children: S.delegate.supportedLocales
          .mapIndexed((index, e) => ListTile(
                title: Text(_locale(e), style: const TextStyle(fontSize: 12)),
                onTap: () => _onLocaleChanged(e),
              ))
          .toList());
}
