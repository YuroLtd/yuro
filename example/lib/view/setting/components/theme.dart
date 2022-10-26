import 'package:example/export.dart';
import 'package:flutter/material.dart';

class ThemeSwitcher extends YuroWidget<YuroAppController> {
  ThemeSwitcher({super.key});

  late final _theme = Yuro.app.theme!.obs;

  List<ColorScheme> get _schemes => defaultThemeColors.map((e) => ColorScheme.fromSeed(seedColor: e)).toList();

  void _onSchemeSelected(ColorScheme scheme) {
    final index = _schemes.indexOf(scheme);
    if (index == Yuro.sp.getInt(kThemeIndex)) return;

    Yuro.sp.setInt(kThemeIndex, index);
    controller.theme = _theme.value = scheme;
    controller.darkTheme = ColorScheme.fromSeed(seedColor: defaultThemeColors[index], brightness: Brightness.dark);
    controller.reload();
  }

  @override
  Widget build(BuildContext context) => ExpansionTile(
          title: Text(S.of(context).theme, style: const TextStyle(fontSize: 14)),
          trailing: Obs((child) => SizedBox(
                width: 20.w,
                height: 20.w,
                child: ColoredBox(color: _theme.value.primary),
              )),
          children: [
            Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.w),
                child: Wrap(
                    spacing: 18.5.w,
                    runSpacing: 18.5.w,
                    children: _schemes.map((scheme) => _ThemeItem(scheme, _onSchemeSelected)).toList()))
          ]);
}

class _ThemeItem extends StatelessWidget {
  final ColorScheme scheme;
  final void Function(ColorScheme scheme) onSelected;

  const _ThemeItem(this.scheme, this.onSelected);

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => onSelected.call(scheme),
        child: SizedBox(width: 20.w, height: 20.w, child: ColoredBox(color: scheme.primary)),
      );
}
