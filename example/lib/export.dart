import 'package:flutter/material.dart';

export 'generated/app_routes.g.dart';
export 'generated/build_config.g.dart';
export 'generated/l10n.dart';


export 'main.dart';
export 'view/view.dart';

export 'package:yuro/yuro.dart';

const kThemeIndex = 'kThemeIndex';
const kThemeMode = 'kThemeMode';
const kLocale = 'kLocale';

List<Color> get defaultThemeColors => [
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
