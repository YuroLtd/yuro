part of 'yuro_app.dart';

extension YuroAppExt on YuroInterface {
  static final YuroAppController _appController = YuroAppController();

  YuroAppController get app => _appController;

  WidgetsBinding get engine => WidgetsFlutterBinding.ensureInitialized();

  ThemeData get theme {
    final brightness = Theme.of(Yuro.currentContext).brightness;
    return brightness == Brightness.light ? app.lightTheme : app.darkTheme;
  }

  ColorScheme get colorScheme => theme.colorScheme;
}

class YuroAppController extends BaseController with WidgetsBindingObserver {
  //
  UniqueKey? _uniqueKey;

  UniqueKey? get uniqueKey => _uniqueKey;

  // light theme
  ThemeData lightTheme = ThemeData.light();
  ThemeData highContrastTheme = ThemeData(colorScheme: const ColorScheme.highContrastLight());

  // dark theme
  ThemeData darkTheme = ThemeData.dark();
  ThemeData highContrastDarkTheme = ThemeData(colorScheme: const ColorScheme.highContrastDark());

  //
  ThemeMode themeMode = ThemeMode.system;

  //
  Locale? locale;

  PageTransitionsBuilder? globalTransition;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    reload(true);
  }

  @override
  void onDispose() {
    super.onDispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  /// 重新加载app, 如果[resetRoute]为true,将重新加载路由
  void reload([bool resetRoute = false]) {
    if (resetRoute) _uniqueKey = UniqueKey();
    refresh();
  }
}
