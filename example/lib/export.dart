import 'package:flutter/material.dart';

export 'main.dart';
export 'generated/generated.dart';
export 'intl/intl.dart';
export 'view/view.dart';

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
