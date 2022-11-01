import 'package:flutter/material.dart';

export 'generated/app_routes.g.dart';
export 'generated/build_config.g.dart';
export 'generated/l10n.dart';


export 'view/components/route_item.dart';
export 'view/components/app_bar.dart';

export 'view/root/root.dart';

export 'view/setting/setting.dart';

export 'view/widgets/widgets.dart';
export 'view/widgets/components/expandable_text.dart';
export 'view/socket/socket.dart';
export 'main.dart';

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
