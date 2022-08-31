import 'package:flutter/material.dart';
import 'package:yuro/util/util.dart';

typedef AnimationBuilder = Widget Function(BuildContext context, AnimationController controller, Widget child);

class OverlayTheme {
  /// 显示位置
  final Alignment alignment;

  /// 显示时长, 为空时一直显示
  final Duration? duration;

  /// 外边距
  final EdgeInsets? margin;

  /// 动画持续时间
  final Duration animationDuration;

  /// 动画曲线
  final Curve animationCurve;

  /// 动画构建器
  final AnimationBuilder animationBuilder;

  OverlayTheme({
    required this.alignment,
    this.duration,
    this.margin,
    required this.animationBuilder,
    this.animationDuration = const Duration(milliseconds: 200),
    this.animationCurve = Curves.linear,
  });

  OverlayTheme copyWith({
    Alignment? alignment,
    Duration? duration,
    EdgeInsets? margin,
    AnimationBuilder? animationBuilder,
    Duration? animationDuration,
    Curve? animationCurve,
  }) =>
      OverlayTheme(
        alignment: alignment ?? this.alignment,
        duration: duration ?? this.duration,
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
  short(Duration(seconds: 1));

  final Duration duration;

  const ToastDuration(this.duration);
}

class ToastTheme extends OverlayTheme {
  final TextStyle textStyle;

  ToastTheme({
    required this.textStyle,
    required super.alignment,
    super.duration,
    super.margin,
    required super.animationBuilder,
    super.animationDuration,
    super.animationCurve,
  });

  @override
  ToastTheme copyWith({
    TextStyle? textStyle,
    Alignment? alignment,
    Duration? duration,
    EdgeInsets? margin,
    AnimationBuilder? animationBuilder,
    Duration? animationDuration,
    Curve? animationCurve,
  }) =>
      ToastTheme(
        textStyle: textStyle ?? this.textStyle,
        alignment: alignment ?? this.alignment,
        duration: duration ?? this.duration,
        margin: margin ?? this.margin,
        animationBuilder: animationBuilder ?? this.animationBuilder,
        animationDuration: animationDuration ?? this.animationDuration,
        animationCurve: animationCurve ?? this.animationCurve,
      );
}
