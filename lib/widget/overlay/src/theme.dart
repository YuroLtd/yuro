import 'package:flutter/material.dart';
import 'package:yuro/util/util.dart';

typedef AnimationBuilder = Widget Function(BuildContext context, AnimationController controller, Widget child);

Widget _defaultOverlayAnimationBuilder(BuildContext context, AnimationController controller, Widget child) =>
    ScaleTransition(
      scale: controller,
      child: Opacity(opacity: controller.value, child: child),
    );

class OverlayTheme {
  /// 背景色
  final Color color;

  /// 显示位置
  final Alignment alignment;

  /// 动画持续时间
  final Duration animationDuration;

  /// 动画曲线
  final Curve animationCurve;

  /// 动画构建器
  final AnimationBuilder animationBuilder;

  OverlayTheme({
    this.color = Colors.transparent,
    this.alignment = Alignment.center,
    this.animationBuilder = _defaultOverlayAnimationBuilder,
    this.animationDuration = const Duration(milliseconds: 200),
    this.animationCurve = Curves.easeIn,
  });

  OverlayTheme copyWith({
    Color? color,
    Alignment? alignment,
    AnimationBuilder? animationBuilder,
    Duration? animationDuration,
    Curve? animationCurve,
  }) =>
      OverlayTheme(
        color: color ?? this.color,
        alignment: alignment ?? this.alignment,
        animationBuilder: animationBuilder ?? this.animationBuilder,
        animationDuration: animationDuration ?? this.animationDuration,
        animationCurve: animationCurve ?? this.animationCurve,
      );
}

enum ToastPosition {
  top(Alignment.topCenter),
  center(Alignment.center),
  bottom(Alignment.bottomCenter);

  final Alignment alignment;

  const ToastPosition(this.alignment);
}

extension ToastPositionExt on ToastPosition {
  EdgeInsets get margin {
    switch (this) {
      case ToastPosition.top:
        return EdgeInsets.only(top: 0.15.sh);
      case ToastPosition.bottom:
        return EdgeInsets.only(bottom: 0.15.sh);
      default:
        return EdgeInsets.zero;
    }
  }
}

enum ToastDuration {
  long(Duration(seconds: 3)),
  short(Duration(milliseconds: 1500));

  final Duration duration;

  const ToastDuration(this.duration);
}

class ToastTheme extends OverlayTheme {
  /// 显示时长,
  final ToastDuration duration;

  /// 文本样式
  final TextStyle textStyle;

  /// 显示位置
  final EdgeInsets margin;

  ToastTheme({
    this.duration = ToastDuration.long,
    this.margin = EdgeInsets.zero,
    this.textStyle = const TextStyle(),
    super.color = Colors.black54,
    super.alignment,
    super.animationBuilder,
    super.animationDuration,
    super.animationCurve,
  });

  @override
  ToastTheme copyWith({
    ToastDuration? duration,
    TextStyle? textStyle,
    EdgeInsets? margin,
    Color? color,
    Alignment? alignment,
    AnimationBuilder? animationBuilder,
    Duration? animationDuration,
    Curve? animationCurve,
  }) =>
      ToastTheme(
        duration: duration ?? this.duration,
        textStyle: textStyle ?? this.textStyle,
        margin: margin ?? this.margin,
        color: color ?? this.color,
        alignment: alignment ?? this.alignment,
        animationBuilder: animationBuilder ?? super.animationBuilder,
        animationDuration: animationDuration ?? super.animationDuration,
        animationCurve: animationCurve ?? super.animationCurve,
      );
}

class LoadingTheme extends OverlayTheme {
  LoadingTheme({
    super.color,
    super.alignment,
    super.animationBuilder,
    super.animationDuration,
    super.animationCurve,
  });

  @override
  LoadingTheme copyWith({
    Color? color,
    Alignment? alignment,
    Duration? duration,
    AnimationBuilder? animationBuilder,
    Duration? animationDuration,
    Curve? animationCurve,
  }) =>
      LoadingTheme(
        color: color ?? this.color,
        alignment: alignment ?? this.alignment,
        animationBuilder: animationBuilder ?? this.animationBuilder,
        animationDuration: animationDuration ?? this.animationDuration,
        animationCurve: animationCurve ?? this.animationCurve,
      );
}
