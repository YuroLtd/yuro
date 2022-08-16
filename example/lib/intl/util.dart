import 'package:example/export.dart';
import 'package:flutter/material.dart';


extension AppLocalizationsExt on BuildContext {
  AppLocalizations get localizations => AppLocalizations.of(this)!;
}
