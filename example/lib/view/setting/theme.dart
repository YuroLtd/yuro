import 'package:flutter/material.dart';

class ThemeSwitchPage extends StatelessWidget {
  const ThemeSwitchPage({super.key});

  static const themeColor = [
    Colors.red,
    Colors.pink,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.cyan,
    Colors.blue,
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('SettingThemePage')),
      );
}
