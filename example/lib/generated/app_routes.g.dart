// ignore_for_file: constant_identifier_names

import 'package:example/export.dart';

class AppRouteKeys {
  AppRouteKeys._();

  static const root = '/';

  static const setting = '/setting';
  static const setting_theme = '/setting/theme';
  static const setting_locale = '/setting/locale';

  static const socket = '/socket';

  static const home_product = '/home/:pid';
  static const home_product_component = '/home/:pid/:cid';
}

class AppRoutes {
  AppRoutes._();

  static List<YuroPage> pages = [
    YuroPage(name: '/', builder: () => Root(), children: [
      YuroPage(name: '/socket', builder: () => const SocketDemo()),
      YuroPage(name: '/setting', builder: () => SettingPage(), children: [
        YuroPage(name: '/theme', builder: () => const ThemeSwitchPage()),
        YuroPage(name: '/locale', builder: () => const LocaleSwitchPage()),
      ]),
    ]),
  ];
}
