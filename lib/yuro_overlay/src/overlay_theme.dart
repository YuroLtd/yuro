import 'package:flutter/material.dart';

class OverlayPosition {
  final Alignment alignment;
  final EdgeInsets offset;

  const OverlayPosition(this.alignment, this.offset);

  static const OverlayPosition top = OverlayPosition(Alignment.topCenter, EdgeInsets.only(top: 72));

  static const OverlayPosition center = OverlayPosition(Alignment.center, EdgeInsets.zero);

  static const OverlayPosition bottom = OverlayPosition(Alignment.bottomCenter, EdgeInsets.only(bottom: 36));

  OverlayPosition copyWith({Alignment? alignment, EdgeInsets? offset}) =>
      OverlayPosition(alignment ?? this.alignment, offset ?? this.offset);
}

typedef AnimationBuilder = Widget Function(
    BuildContext context,
    AnimationController controller,
    double percent,
    Widget child,
    );

class OverlayTheme {
  // 显示位置
  late final OverlayPosition position;

  // 动画持续时间
  late final Duration animationDuration;

  // 动画曲线
  late final Curve animationCurve;

  // Overlay显示时长
  late final Duration duration;

  // 只显示一个悬浮组件
  late final bool onlyOne;

  OverlayTheme({
    OverlayPosition? position,
    AnimationBuilder? animationBuilder,
    Duration? animationDuration,
    Curve? animationCurve,
    Duration? duration,
    bool? onlyOne,
  }) {
    this.position = position ?? OverlayPosition(Alignment.center, EdgeInsets.zero);
    this.animationDuration = animationDuration ?? const Duration(milliseconds: 200);
    this.animationCurve = animationCurve ?? Curves.easeIn;
    this.duration = duration ?? const Duration(milliseconds: 2000);
    this.onlyOne = onlyOne ?? true;
    assert(this.duration > this.animationDuration);
  }
}
