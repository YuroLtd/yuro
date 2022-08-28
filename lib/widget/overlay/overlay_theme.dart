part of 'overlay.dart';

typedef AnimationBuilder = Widget Function(
  BuildContext context,
  AnimationController controller,
  double percent,
  Widget child,
);

class OverlayTheme {
  /// 显示位置
  final Alignment alignment;

  /// 显示时长
  final Duration duration;

  /// 背景
  final Decoration background;

  /// 外边距
  final EdgeInsets margin;

  /// 内边距
  final EdgeInsets padding;

  /// 动画构建器
  final AnimationBuilder animationBuilder;

  /// 动画持续时间
  final Duration animationDuration;

  /// 动画曲线
  final Curve animationCurve;

  OverlayTheme(
    this.alignment,
    this.duration,
    this.background,
    this.margin,
    this.padding,
    this.animationBuilder,
    this.animationDuration,
    this.animationCurve,
  );

  OverlayTheme copyWith({
    Alignment? alignment,
    Duration? duration,
    Decoration? background,
    EdgeInsets? margin,
    EdgeInsets? padding,
    AnimationBuilder? animationBuilder,
    Duration? animationDuration,
    Curve? animationCurve,
  }) =>
      OverlayTheme(
        alignment ?? this.alignment,
        duration ?? this.duration,
        background ?? this.background,
        margin ?? this.margin,
        padding ?? this.padding,
        animationBuilder ?? this.animationBuilder,
        animationDuration ?? this.animationDuration,
        animationCurve ?? this.animationCurve,
      );
}

class ToastTheme extends OverlayTheme {
  final TextStyle textStyle;

  ToastTheme(
    this.textStyle,
    super.alignment,
    super.duration,
    super.background,
    super.margin,
    super.padding,
    super.animationBuilder,
    super.animationDuration,
    super.animationCurve,
  );

  @override
  ToastTheme copyWith({
    TextStyle? textStyle,
    Alignment? alignment,
    Duration? duration,
    Decoration? background,
    EdgeInsets? margin,
    EdgeInsets? padding,
    AnimationBuilder? animationBuilder,
    Duration? animationDuration,
    Curve? animationCurve,
  }) =>
      ToastTheme(
        textStyle ?? this.textStyle,
        alignment ?? this.alignment,
        duration ?? this.duration,
        background ?? this.background,
        margin ?? this.margin,
        padding ?? this.padding,
        animationBuilder ?? this.animationBuilder,
        animationDuration ?? this.animationDuration,
        animationCurve ?? this.animationCurve,
      );
}
