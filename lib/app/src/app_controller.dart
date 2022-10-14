part of 'yuro_app.dart';

extension YuroAppExt on YuroInterface {
  static final YuroAppController _appController = YuroAppController();

  YuroAppController get app => _appController;

  WidgetsBinding get engine => WidgetsFlutterBinding.ensureInitialized();
}

class YuroAppController extends YuroController {
  //
  UniqueKey? _uniqueKey;

  UniqueKey? get uniqueKey => _uniqueKey;

  // light theme
  ColorScheme theme = const ColorScheme.light();
  ColorScheme? highContrastTheme;

  // dark theme
  ColorScheme darkTheme = const ColorScheme.dark();
  ColorScheme? highContrastDarkTheme;

  //
  ThemeMode themeMode = ThemeMode.system;

  //
  Locale? locale;

  /// 重新加载app, 如果[resetRoute]为true,将重新加载路由
  void reload([bool resetRoute = false]) {
    if (resetRoute) _uniqueKey = UniqueKey();
    refresh();
  }
}
