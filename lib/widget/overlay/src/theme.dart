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

  /// 显示位置
  final EdgeInsets margin;

  /// 动画持续时间
  final Duration animationDuration;

  /// 动画曲线
  final Curve animationCurve;

  /// 动画构建器
  final AnimationBuilder animationBuilder;

  OverlayTheme({
    this.color = Colors.transparent,
    this.alignment = Alignment.center,
    this.margin = EdgeInsets.zero,
    this.animationBuilder = _defaultOverlayAnimationBuilder,
    this.animationDuration = const Duration(milliseconds: 200),
    this.animationCurve = Curves.easeIn,
  });

  OverlayTheme copyWith({
    Color? color,
    Alignment? alignment,
    EdgeInsets? margin,
    AnimationBuilder? animationBuilder,
    Duration? animationDuration,
    Curve? animationCurve,
  }) =>
      OverlayTheme(
        color: color ?? this.color,
        alignment: alignment ?? this.alignment,
        margin: margin ?? this.margin,
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
  middle(Duration(seconds: 2)),
  short(Duration(seconds: 1));

  final Duration duration;

  const ToastDuration(this.duration);
}

class ToastTheme extends OverlayTheme {
  /// 显示时长,
  final ToastDuration duration;

  /// 文本样式
  final TextStyle textStyle;

  ToastTheme({
    this.duration = ToastDuration.middle,
    this.textStyle = const TextStyle(),
    super.color = Colors.black54,
    super.alignment,
    super.margin,
    super.animationBuilder,
    super.animationDuration,
    super.animationCurve,
  });

  @override
  ToastTheme copyWith({
    ToastDuration? duration,
    TextStyle? textStyle,
    Color? color,
    Alignment? alignment,
    EdgeInsets? margin,
    AnimationBuilder? animationBuilder,
    Duration? animationDuration,
    Curve? animationCurve,
  }) =>
      ToastTheme(
        duration: duration ?? this.duration,
        textStyle: textStyle ?? this.textStyle,
        color: color ?? this.color,
        alignment: alignment ?? this.alignment,
        margin: margin ?? this.margin,
        animationBuilder: animationBuilder ?? super.animationBuilder,
        animationDuration: animationDuration ?? super.animationDuration,
        animationCurve: animationCurve ?? super.animationCurve,
      );
}

class LoadingTheme extends OverlayTheme {
  final Widget child;

  LoadingTheme({
    required this.child,
    super.color,
    super.alignment,
    super.margin,
    super.animationBuilder,
    super.animationDuration,
    super.animationCurve,
  });

  @override
  LoadingTheme copyWith({
    Widget? child,
    Color? color,
    Alignment? alignment,
    EdgeInsets? margin,
    Duration? duration,
    AnimationBuilder? animationBuilder,
    Duration? animationDuration,
    Curve? animationCurve,
  }) =>
      LoadingTheme(
        child: child ?? this.child,
        color: color ?? this.color,
        alignment: alignment ?? this.alignment,
        margin: margin ?? this.margin,
        animationBuilder: animationBuilder ?? this.animationBuilder,
        animationDuration: animationDuration ?? this.animationDuration,
        animationCurve: animationCurve ?? this.animationCurve,
      );
}
