// ignore_for_file: constant_identifier_names

import 'package:example/export.dart';

class AppRouteKeys {
  AppRouteKeys._();

  static const root = '/';

  static const exception = '/exception';

  static const widgets = '/widgets';
  static const widgets_expandable_text = '/widgets/expandable_text';

  static const setting = '/setting';

  static const socket = '/socket';
}

class AppRoutes {
  AppRoutes._();

  static List<YuroPage> pages = [
    YuroPage(name: '/', builder: () => const RootPage(), children: [
      YuroPage(name: '/exception', builder: () => const ExceptionPage()),

      YuroPage(name: '/widgets', builder: () => const WidgetsPage(), children: [
        YuroPage(name: '/expandable_text', builder: () => const ExpandableTextDemo()),
      ]),

      YuroPage(name: '/setting', builder: () => const SettingPage()),
    ]),
  ];
}
