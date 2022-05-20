part of 'yuro_app.dart';

class YuroAppController extends YuroController {
  static const String KEY_LOCALE = 'key_locale';
  static const String KEY_THEME_MODE = 'key_theme_mode';

  final _uniqueKey = ValueNotifier(UniqueKey());

  YuroAppController(
    this._fallbackLocale,
    this._translations,
  );

  // theme mode
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  set themeMode(ThemeMode newThemeMode) {
    if (_themeMode == newThemeMode) return;
    _themeMode = newThemeMode;
    Yuro.sp.setInt(KEY_THEME_MODE, newThemeMode.index);
    reload();
  }

  // locale
  Locale? _locale;

  Locale? get locale => _locale;

  set locale(Locale? locale) {
    if (_locale == locale) return;
    _locale = locale;
    Yuro.sp.setString(KEY_LOCALE, '${_locale?.languageCode}_${_locale?.countryCode}');
    reload();
  }

  // fallback locale
  final Locale _fallbackLocale;

  Locale get fallbackLocale => _fallbackLocale;

  // translations
  final Map<String, Map<String, String>> _translations;

  Map<String, Map<String, String>> get translations => _translations;

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
    await Yuro.loadPackageInfo();
    // 在非调试模式下,上传应用错误记录
    if (kReleaseMode) YuroCrashlytics.instance.upload();
  }

  void reload() => _uniqueKey.value = UniqueKey();
}
