import 'dart:math';

import 'package:flutter/material.dart';
import 'package:yuro/app/app.dart';
import 'package:yuro/core/core.dart';

class RingInsideWithText extends StatelessWidget {
  final String text;

  const RingInsideWithText({this.text = 'loading...', super.key});
  @override
  Widget build(BuildContext context) => Container(
      padding: const EdgeInsets.all(7.5),
      decoration: BoxDecoration(
        color: Yuro.app.theme?.onSecondaryContainer,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        const RingInside(radius: 10),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: DefaultTextStyle(style: const TextStyle(), child: Text(text)),
        )
      ]));
}

class RingInside extends StatefulWidget {
  final double radius;
  final Color? color;
  final Color? backgroudColor;
  final double strokenWidth;
  final Duration duration;

  const RingInside({
    this.radius = 15,
    this.color,
    this.backgroudColor,
    this.strokenWidth = 4,
    this.duration = const Duration(milliseconds: 1200),
    super.key,
  });

  @override
  RingInsideState createState() => RingInsideState();
}

class RingInsideState extends State<RingInside> with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(vsync: this, duration: widget.duration)..repeat();
  late final _animation = _controller.drive(CurveTween(curve: Curves.linear));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color get color => widget.color ?? (Yuro.app.theme ?? const ColorScheme.light()).primary;

  Color get backgroudColor => widget.backgroudColor ?? (Yuro.app.theme ?? const ColorScheme.light()).surfaceVariant;

  @override
  Widget build(BuildContext context) => SizedBox.fromSize(
      size: Size.fromRadius(widget.radius),
      child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) => CustomPaint(
                painter: _RingPainter(color, backgroudColor, widget.strokenWidth, _animation.value * 2 * pi),
              )));
}

class _RingPainter extends CustomPainter {
  final Color color;
  final Color backgroudColor;
  final double strokenWidth;
  final double startAngle;

  _RingPainter(this.color, this.backgroudColor, this.strokenWidth, this.startAngle);

  late final _paint = Paint()
    ..color = color
    ..strokeWidth = strokenWidth
    ..strokeCap = StrokeCap.round
    ..style = PaintingStyle.stroke;

  late final _backgroundPaint = Paint()
    ..color = backgroudColor
    ..strokeWidth = strokenWidth
    ..strokeCap = StrokeCap.round
    ..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.width / 2;
    final center = size.center(Offset.zero);

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), 0, pi * 2, false, _backgroundPaint);

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle, pi / 3, false, _paint);
  }

  @override
  bool shouldRepaint(covariant _RingPainter old) =>
      startAngle != old.startAngle ||
      color != old.color ||
      backgroudColor != old.backgroudColor ||
      strokenWidth != old.strokenWidth;
}
