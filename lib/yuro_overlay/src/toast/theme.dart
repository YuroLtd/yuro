import 'package:flutter/material.dart';

import '../overlay_theme.dart';

class ToastTheme extends OverlayTheme {
  // 文本样式
  final TextStyle style;

  // 背景颜色
  final Color color;

  // 圆角半径
  final double radius;

  // 内边距
  final EdgeInsets padding;

  // 动画构建器
  final AnimationBuilder animationBuilder;

  ToastTheme({
    this.style = const TextStyle(fontSize: 15, fontWeight: FontWeight.normal, color: Colors.white),
    this.color = const Color(0xFF757575),
    this.radius = 5,
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    this.animationBuilder = _defaultAnimationBuilder,
    OverlayPosition position = OverlayPosition.bottom,
    Duration? animationDuration,
    Curve? animationCurve,
    Duration? duration,
    bool? onlyOne,
  }) : super(
          position: position,
          animationBuilder: animationBuilder,
          animationDuration: animationDuration,
          animationCurve: animationCurve,
          duration: duration,
          onlyOne: onlyOne,
        );

  ToastTheme copyWith({
    TextStyle? style,
    Color? color,
    double? radius,
    EdgeInsets? padding,
    OverlayPosition? position,
    AnimationBuilder? animationBuilder,
    Duration? animationDuration,
    Curve? animationCurve,
    Duration? duration,
    bool? onlyOne,
  }) =>
      ToastTheme(
        style: style ?? this.style,
        color: color ?? this.color,
        radius: radius ?? this.radius,
        padding: padding ?? this.padding,
        position: position ?? this.position,
        animationBuilder: animationBuilder ?? this.animationBuilder,
        animationDuration: animationDuration ?? this.animationDuration,
        animationCurve: animationCurve ?? this.animationCurve,
        duration: duration ?? this.duration,
        onlyOne: onlyOne ?? this.onlyOne,
      );
}

// 默认的动画构建器
Widget _defaultAnimationBuilder(
  BuildContext context,
  AnimationController controller,
  double percent,
  Widget child,
) =>
    ScaleTransition(scale: controller, child: Opacity(opacity: percent, child: child));
