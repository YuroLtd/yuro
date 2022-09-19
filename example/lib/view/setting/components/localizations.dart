import 'package:example/export.dart';
import 'package:flutter/material.dart';

class LocalizationsSwitcher extends YuroWidget<YuroAppController> {
  LocalizationsSwitcher({super.key});

  late final locale = controller.locale.obs;

  void _onLocaleChanged(Locale value) async {
    if (locale.value == value) return;
    final stringBox = await Yuro.openHiveBox<String>();
    if (value.languageCode == 'followSystem') {
      controller.locale = locale.value = null;
      stringBox.delete(kLocale);
    } else {
      controller.locale = locale.value = value;
      stringBox.put(kLocale, value.toLanguageTag());
    }
    controller.reload();
  }

  @override
  Widget build(BuildContext context) => ExpansionTile(
      title: Text(context.localizations.settingLocale, style: const TextStyle(fontSize: 12)),
      trailing: Obs((child) => Text(locale.value?.desc ?? context.localizations.followSystem)),
      children: [const Locale('followSystem'), ...AppLocalizations.supportedLocales]
          .map((e) => ListTile(
                title: Text(e.desc, style: const TextStyle(fontSize: 12)),
                onTap: () => _onLocaleChanged(e),
              ))
          .toList());
}
