import 'dart:math';

import 'package:flutter/material.dart';

class BallCircleOpacity extends StatefulWidget {
  final double radius;

  /// 小球的颜色
  final Color? color;

  /// 旋转速度
  final Duration duration;

  const BallCircleOpacity({
    super.key,
    this.radius = 15,
    this.color,
    this.duration = const Duration(milliseconds: 1200),
  });

  @override
  BallCircleOpacityState createState() => BallCircleOpacityState();
}

class BallCircleOpacityState extends State<BallCircleOpacity> with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(vsync: this, duration: widget.duration)..repeat();
  late final _animation = _controller.drive(CurveTween(curve: Curves.linear));

  final _opacity = [0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.9, 1.0];
  final List<List<Color>> _colorSchemes = [];

  Color get color => widget.color ?? Theme.of(context).colorScheme.primary;

  @override
  void initState() {
    super.initState();
    final colors = _opacity.map((e) => color.withOpacity(e)).toList();
    List.generate(colors.length, (index) {
      final tempList = <Color>[];
      tempList.clear();
      tempList.addAll(colors.sublist(colors.length - index, colors.length));
      tempList.addAll(colors.sublist(0, colors.length - index));
      _colorSchemes.add(tempList);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SizedBox.fromSize(
      size: Size.fromRadius(widget.radius),
      child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final index = (_animation.value * _opacity.length).floor();
            return CustomPaint(painter: _BallPainter(_colorSchemes[index]));
          }));
}

class _BallPainter extends CustomPainter {
  final List<Color> colors;

  _BallPainter(this.colors);

  late final _paint = Paint()..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.width / 2;
    final center = size.center(Offset.zero);

    final ballRadius = size.width / 8;
    final perAngle = 2 * pi / colors.length;

    List.generate(colors.length, (index) {
      _paint.color = colors[index];
      final offset = Offset(
        center.dx + radius * cos(perAngle * index),
        center.dy + radius * sin(perAngle * index),
      );
      canvas.drawCircle(offset, ballRadius, _paint);
    });
  }

  @override
  bool shouldRepaint(covariant _BallPainter old) => colors != old.colors;
}
