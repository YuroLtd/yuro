import 'package:example/export.dart';
import 'package:flutter/material.dart';

class ThemeModeSwitcher extends YuroWidget<YuroAppController> {
  ThemeModeSwitcher({super.key});

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
                    Text(context.localizations.system, style: TextStyle(fontSize: 12.sp)),
                    Text(context.localizations.lightMode, style: TextStyle(fontSize: 12.sp)),
                    Text(context.localizations.darkMode, style: TextStyle(fontSize: 12.sp)),
                  ])));
}
