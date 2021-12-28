part of 'toast.dart';

class ToastPosition {
  final Alignment alignment;
  final EdgeInsets offset;

  const ToastPosition(this.alignment, this.offset);

  static const ToastPosition top = ToastPosition(Alignment.topCenter, EdgeInsets.only(top: 72));

  static const ToastPosition center = ToastPosition(Alignment.center, EdgeInsets.zero);

  static const ToastPosition bottom = ToastPosition(Alignment.bottomCenter, EdgeInsets.only(bottom: 36));

  ToastPosition copyWith({Alignment? alignment, EdgeInsets? offset}) =>
      ToastPosition(alignment ?? this.alignment, offset ?? this.offset);
}

typedef AnimationBuilder = Widget Function(
  BuildContext context,
  AnimationController controller,
  double percent,
  Widget child,
);

class ToastTheme {
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

  // 显示位置
  final ToastPosition position;

  // 动画持续时间
  final Duration animationDuration;

  // 动画曲线
  final Curve animationCurve;

  // Overlay显示时长
  final Duration duration;

  // 只显示一个悬浮组件
  final bool onlyOne;

  ToastTheme({
    this.style = const TextStyle(fontSize: 15, fontWeight: FontWeight.normal, color: Colors.white),
    this.backgroundColor = const Color(0xFF757575),
    this.radius = 5,
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    this.animationBuilder = _defaultAnimationBuilder,
    this.position = ToastPosition.bottom,
    this.animationDuration = const Duration(milliseconds: 200),
    this.animationCurve = Curves.easeIn,
    this.duration = const Duration(milliseconds: 2000),
    this.onlyOne = true,
  }) : assert(duration > animationDuration);

  ToastTheme copyWith({
    TextStyle? style,
    Color? backgroundColor,
    double? radius,
    EdgeInsets? padding,
    ToastPosition? position,
    AnimationBuilder? animationBuilder,
    Duration? animationDuration,
    Curve? animationCurve,
    Duration? duration,
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
    ScaleTransition(scale: controller, child: Opacity(opacity: percent, child: child));
