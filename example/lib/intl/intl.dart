import 'package:example/export.dart';
import 'package:flutter/material.dart';

export 'app_localizations.dart';

extension AppLocalizationsExt on BuildContext {
  AppLocalizations get localizations => AppLocalizations.of(this)!;
}

extension LocaleExt on Locale {
  String get desc {
    switch (languageCode) {
      case 'zh':
        switch (countryCode) {
          case 'HK':
            return '中文(繁体)';
          case 'TW':
            return '中文(繁體)';
          default:
            return '中文(简体)';
        }
      case 'followSystem':
        return Yuro.currentContext.localizations.followSystem;
      default:
        return 'UNKNOWN';
    }
  }
}
