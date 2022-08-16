import 'package:example/export.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: Text(context.localizations.setting), elevation: 0),
      body: ListView(children: [
        RouteItem(name: context.localizations.settingLocale, route: AppRouteKeys.setting_locale),
        ThemeSwitcher(),
        _DarkModeSwitcher(),
      ]));
}

class _LocaleSwitcher extends YuroWidget<YuroAppController> {
  @override
  Widget build(BuildContext context) => Container();
}

class ThemeSwitcher extends YuroWidget<YuroAppController> {
  ThemeSwitcher({super.key});

  final _colorIndex = 0.obs;

  void onColorSelected(int index) {
    Yuro.hive<int>((box) => box.put(kThemeColor, index));
    _colorIndex.value = index;
    controller.theme = defaultColorScheme[index];
    controller.darkTheme = defaultDarkColorScheme[index];
    controller.reload();
  }

  @override
  Widget build(BuildContext context) => ExpansionTile(
          title: Text(context.localizations.settingTheme, style: TextStyle(fontSize: 12.sp)),
          trailing: Obs((child) => SizedBox(
                width: 20.w,
                height: 20.w,
                child: ColoredBox(color: defaultColorScheme[_colorIndex.value].primary),
              )),
          children: [
            Padding(
                padding: EdgeInsets.all(12.w),
                child: Wrap(
                    spacing: 20.w,
                    runSpacing: 20.w,
                    children: defaultColorScheme
                        .mapIndexed((index, color) => _ThemeItem(index, color, onColorSelected))
                        .toList()))
          ]);
}

class _ThemeItem extends StatelessWidget {
  final int index;
  final ColorScheme color;
  final void Function(int index) onSelected;

  const _ThemeItem(this.index, this.color, this.onSelected);

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => onSelected.call(index),
        child: SizedBox(width: 20.w, height: 20.w, child: ColoredBox(color: color.primary)),
      );
}

class _DarkModeSwitcher extends YuroWidget<YuroAppController> {
  late final _isSelected = ThemeMode.values.map((e) => e == controller.themeMode).toList().obs;

  void _onPressed(int index) {
    Yuro.hive<int>((box) => box.put(kThemeMode, index));
    final mode = ThemeMode.values[index];
    controller.themeMode = mode;
    _isSelected.value = ThemeMode.values.map((e) => e == mode).toList();
    controller.reload();
  }

  @override
  Widget build(BuildContext context) => ListTile(
      title: Text(context.localizations.settingDarkMode, style: TextStyle(fontSize: 12.sp)),
      trailing: ObsValue<List<bool>>(
          notifier: _isSelected,
          builder: (list, child) => ToggleButtons(
                  isSelected: list,
                  onPressed: _onPressed,
                  borderRadius: BorderRadius.circular(5.w),
                  constraints: BoxConstraints(minHeight: 30.w, minWidth: 40.w),
                  children: [
                    Text(context.localizations.followSystem, style: TextStyle(fontSize: 12.sp)),
                    Text(context.localizations.lightMode, style: TextStyle(fontSize: 12.sp)),
                    Text(context.localizations.darkMode, style: TextStyle(fontSize: 12.sp)),
                  ])));
}
