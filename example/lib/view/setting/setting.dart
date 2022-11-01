import 'package:example/export.dart';
import 'package:flutter/material.dart';

import 'components/localization.dart';
import 'components/theme.dart';
import 'components/theme_mode.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: appBar(title: S.of(context).setting),
      body: ListView(children: [
        const LocalizationSwitcher(),
        SizedBox.fromSize(size: Size.fromHeight(5.w), child: ColoredBox(color: Theme.of(context).dividerColor)),
        ThemeSwitcher(),
        Divider(height: 1.w),
        ThemeModeSwitcher(),
        SizedBox.fromSize(size: Size.fromHeight(5.w), child: ColoredBox(color: Theme.of(context).dividerColor)),
      ]));
}
