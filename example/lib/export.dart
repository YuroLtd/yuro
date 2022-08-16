// generated
import 'package:flutter/material.dart';

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
export 'view/setting/locale.dart';
export 'view/setting/theme.dart';

export 'view/socket/socket.dart';

export 'package:yuro/yuro.dart';

const kThemeColor = 'kThemeColor';
const kThemeMode = 'kThemeMode';

List<Color> get _defaultThemeColor => [
      Colors.red,
      Colors.pink,
      Colors.green,
      Colors.yellow,
      Colors.orange,
      Colors.cyan,
      Colors.blue,
    ];

List<ColorScheme> get defaultColorScheme => _defaultThemeColor.map((e) {
      return ColorScheme.fromSeed(seedColor: e);
    }).toList();

List<ColorScheme> get defaultDarkColorScheme => _defaultThemeColor.map((e) {
      return ColorScheme.fromSeed(seedColor: e, brightness: Brightness.dark);
    }).toList();
