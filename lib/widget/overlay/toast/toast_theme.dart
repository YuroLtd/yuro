part of 'toast.dart';

/// toast显示时间 [long]-3秒 [short]-1秒
enum ToastDuration { long, short }

/// toast显示位置
enum ToastPosition { top, center, bottom }

typedef AnimationBuilder = Widget Function(
  BuildContext context,
  AnimationController controller,
  double percent,
  Widget child,
);

class ToastTheme {
  // 显示位置
  final ToastPosition position;

  // Overlay显示时长
  final ToastDuration duration;

  // 文本样式
  final TextStyle style;

  // 背景颜色
  final Color backgroundColor;

  // 圆角半径
  final double radius;

  // 内边距
  final EdgeInsets padding;

  // 动画构建器
  final AnimationBuilder animationBuilder;

  // 动画持续时间
  final Duration animationDuration;

  // 动画曲线
  final Curve animationCurve;

  // 只显示一个悬浮组件
  final bool onlyOne;

  ToastTheme({
    this.style = const TextStyle(fontSize: 14, color: Colors.white),
    this.backgroundColor = const Color(0xFF757575),
    this.radius = 5,
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    this.animationBuilder = _defaultAnimationBuilder,
    this.position = ToastPosition.bottom,
    this.animationDuration = const Duration(milliseconds: 250),
    this.animationCurve = Curves.easeIn,
    this.duration = ToastDuration.short,
    this.onlyOne = true,
  });

  ToastTheme copyWith({
    TextStyle? style,
    Color? backgroundColor,
    double? radius,
    EdgeInsets? padding,
    ToastPosition? position,
    ToastDuration? duration,
    AnimationBuilder? animationBuilder,
    Duration? animationDuration,
    Curve? animationCurve,
    bool? onlyOne,
  }) =>
      ToastTheme(
        style: style ?? this.style,
        backgroundColor: backgroundColor ?? this.backgroundColor,
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
    ScaleTransition(
      scale: controller,
      child: Opacity(opacity: percent, child: child),
    );
