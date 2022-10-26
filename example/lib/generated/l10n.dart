// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `简体中文`
  String get locale {
    return Intl.message(
      '简体中文',
      name: 'locale',
      desc: '',
      args: [],
    );
  }

  /// `设置`
  String get setting {
    return Intl.message(
      '设置',
      name: 'setting',
      desc: '',
      args: [],
    );
  }

  /// `跟随系统`
  String get followSystem {
    return Intl.message(
      '跟随系统',
      name: 'followSystem',
      desc: '',
      args: [],
    );
  }

  /// `多语言`
  String get language {
    return Intl.message(
      '多语言',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `系统`
  String get system {
    return Intl.message(
      '系统',
      name: 'system',
      desc: '',
      args: [],
    );
  }

  /// `主题模式`
  String get themeMode {
    return Intl.message(
      '主题模式',
      name: 'themeMode',
      desc: '',
      args: [],
    );
  }

  /// `深色`
  String get darkMode {
    return Intl.message(
      '深色',
      name: 'darkMode',
      desc: '',
      args: [],
    );
  }

  /// `浅色`
  String get lightMode {
    return Intl.message(
      '浅色',
      name: 'lightMode',
      desc: '',
      args: [],
    );
  }

  /// `主题`
  String get theme {
    return Intl.message(
      '主题',
      name: 'theme',
      desc: '',
      args: [],
    );
  }

  /// `组件`
  String get widgets {
    return Intl.message(
      '组件',
      name: 'widgets',
      desc: '',
      args: [],
    );
  }

  /// `可折叠文本`
  String get expandableText {
    return Intl.message(
      '可折叠文本',
      name: 'expandableText',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'zh'),
      Locale.fromSubtags(languageCode: 'zh', countryCode: 'HK'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
