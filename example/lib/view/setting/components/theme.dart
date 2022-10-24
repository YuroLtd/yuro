import 'package:example/export.dart';
import 'package:flutter/material.dart';

class ThemeSwitcher extends YuroWidget<YuroAppController> {
  ThemeSwitcher({super.key});

  late final _colorIndex = defaultColorScheme.indexOf(controller.theme ?? const ColorScheme.light()).obs;

  void onColorSelected(int index) {
    // Yuro.hive<int>((box) => box.put(kThemeColor, index));
    // _colorIndex.value = index;
    // controller.theme = defaultColorScheme[index];
    // controller.darkTheme = defaultDarkColorScheme[index];
    // controller.reload();
  }

  @override
  Widget build(BuildContext context) => ExpansionTile(
          title: Text(context.localizations.settingTheme, style: const TextStyle(fontSize: 12)),
          trailing: Obs((child) => SizedBox(
                width: 20.w,
                height: 20.w,
                child: ColoredBox(color: defaultColorScheme[_colorIndex.value].primary),
              )),
          children: [
            Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.w),
                child: Wrap(
                    spacing: 18.5.w,
                    runSpacing: 18.5.w,
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
