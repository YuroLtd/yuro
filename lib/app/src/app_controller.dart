part of 'yuro_app.dart';

extension YuroAppExt on YuroInterface {
  static final YuroAppController _appController = YuroAppController();

  YuroAppController get app => _appController;

  WidgetsBinding get engine => WidgetsFlutterBinding.ensureInitialized();
}

class YuroAppController extends YuroController with WidgetsBindingObserver {
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

  @override
  void onInit() {
    WidgetsBinding.instance.addObserver(this);
    super.onInit();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) => Yuro.fire(state);

  /// 重新加载app, 如果[resetRoute]为true,将重新加载路由
  void reload([bool resetRoute = false]) {
    if (resetRoute) _uniqueKey = UniqueKey();
    refresh();
  }
}
