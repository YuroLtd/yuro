import 'package:flutter/material.dart';
import 'package:yuro/yuro_core/yuro_core.dart';
import 'package:yuro/yuro_overlay/yuro_overlay.dart';

import 'theme.dart';

extension YuroToastExt on YuroInterface {
  static ToastTheme _toastTheme = ToastTheme();

  ToastTheme get toastTheme => _toastTheme;

  set toastTheme(ToastTheme newTheme) => _toastTheme = newTheme;

  void showToast(String text, {ToastTheme? theme}) {
    final currentTheme = theme ?? _toastTheme;
    final widget = Container(
      margin: const EdgeInsets.only(bottom: 50),
      padding: currentTheme.padding,
      decoration: BoxDecoration(
        color: currentTheme.color,
        borderRadius: BorderRadius.circular(currentTheme.radius),
      ),
      child: ClipRect(child: DefaultTextStyle(style: currentTheme.style, child: Text(text))),
    );
    Yuro.showAnimatedWidget(tag: 'Toast', builder: currentTheme.animationBuilder, child: widget, theme: currentTheme);
  }
}
