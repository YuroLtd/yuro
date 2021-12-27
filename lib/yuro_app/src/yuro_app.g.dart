part of 'yuro_app.dart';

class YuroAppController extends YuroController {
  static const String KEY_LOCALE = 'key_locale';
  static const String KEY_THEME_MODE = 'key_theme_mode';

  final _uniqueKey = ValueNotifier(UniqueKey());
  ThemeMode _themeMode = ThemeMode.system;
  Locale? _locale;

  late final AppInfo _appInfo;

  @override
  void onInit() {
    //加载ThemeMode
    final themeModeIndex = Yuro.sp.getInt(KEY_THEME_MODE);
    if (themeModeIndex != null) {
      _themeMode = ThemeMode.values[themeModeIndex];
    }

    //加载Locale
    final localeCache = Yuro.sp.getString(KEY_LOCALE);
    if (localeCache != null) {
      final config = localeCache.split('_');
      _locale = Locale(config[0], config.length == 2 ? config[1] : null);
    }
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
    // 加载应用信息
    _appInfo = await YuroPlugin().app.appInfo();
  }

  void reload() => _uniqueKey.value = UniqueKey();
}
