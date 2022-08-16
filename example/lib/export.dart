import 'package:flutter/material.dart';

// generated
export 'generated/app_routes.g.dart';
export 'generated/build_config.g.dart';

// intl
export 'intl/app_localizations.dart';
export 'intl/util.dart';

// view
export 'view/components/route_item.dart';

export 'view/root/root.dart';
export 'view/product.dart';

export 'view/setting/setting.dart';
export 'view/socket/socket.dart';

export 'package:yuro/yuro.dart';

const kThemeColor = 'kThemeColor';
const kThemeMode = 'kThemeMode';
const kLocale = 'kLocale';

List<Color> get _defaultThemeColor => [
      Colors.red,
      Colors.pink,
      Colors.green,
      Colors.yellow,
      Colors.orange,
      Colors.cyan,
      Colors.blue,
      Colors.grey,
      Colors.teal,
    ];

List<ColorScheme> get defaultColorScheme {
  final list = _defaultThemeColor.map((e) => ColorScheme.fromSeed(seedColor: e)).toList();
  return [const ColorScheme.light(), ...list];
}

List<ColorScheme> get defaultDarkColorScheme {
  final list = _defaultThemeColor.map((e) => ColorScheme.fromSeed(seedColor: e, brightness: Brightness.dark)).toList();
  return [const ColorScheme.dark(), ...list];
}
