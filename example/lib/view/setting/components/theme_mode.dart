import 'package:example/export.dart';
import 'package:flutter/material.dart';

class ThemeModeSwitcher extends YuroWidget<YuroAppController> {
  ThemeModeSwitcher({super.key});

  late final _isSelected = ThemeMode.values.map((e) => e == controller.themeMode).toList().obs;

  void _onPressed(int index) {
    final mode = ThemeMode.values[index];
    if (controller.themeMode == mode) return;
    Yuro.sp.setInt(kThemeMode, index);
    _isSelected.value = ThemeMode.values.map((e) => e == mode).toList();
    controller.themeMode = mode;
    controller.reload();
  }

  @override
  Widget build(BuildContext context) => ListTile(
      title: Text(S.of(context).themeMode, style: const TextStyle(fontSize: 14)),
      trailing: ObsValue<List<bool>>(
          notifier: _isSelected,
          builder: (list, child) => ToggleButtons(
                  isSelected: list,
                  onPressed: _onPressed,
                  borderRadius: BorderRadius.circular(5.w),
                  constraints: BoxConstraints(minHeight: 30.w, minWidth: 40.w),
                  children: [
                    Text(S.of(context).system, style: const TextStyle(fontSize: 12)),
                    Text(S.of(context).lightMode, style: const TextStyle(fontSize: 12)),
                    Text(S.of(context).darkMode, style: const TextStyle(fontSize: 12)),
                  ])));
}
