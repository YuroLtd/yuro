


import 'app_localizations.dart';

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get setting => '设置';

  @override
  String get followSystem => '跟随系统';

  @override
  String get system => '系统';

  @override
  String get localizations => '简体中文';

  @override
  String get darkMode => '深色';

  @override
  String get lightMode => '浅色';

  @override
  String get settingDarkMode => '深色模式';

  @override
  String get settingTheme => '主题';

  @override
  String get settingLocale => '多语言';

  @override
  String get widgets => '小组件';

  @override
  String get expandableText => '可折叠文本';
}

/// The translations for Chinese, as used in Hong Kong (`zh_HK`).
class AppLocalizationsZhHk extends AppLocalizationsZh {
  AppLocalizationsZhHk(): super('zh_HK');

  @override
  String get setting => '設置';

  @override
  String get followSystem => '跟隨系統';

  @override
  String get system => '系统';
}
