import 'dart:math';

import 'package:flutter/material.dart';
import 'package:yuro/app/app.dart';
import 'package:yuro/core/core.dart';

class BallCircleOpacityLoading extends StatefulWidget {
  /// 小球的半径
  final double radius;

  /// 小球的颜色
  final Color? color;

  /// 旋转速度
  final Duration duration;

  const BallCircleOpacityLoading({
    super.key,
    this.radius = 5,
    this.color,
    this.duration = const Duration(milliseconds: 1200),
  });

  @override
  BallCircleOpacityLoadingState createState() => BallCircleOpacityLoadingState();
}

class BallCircleOpacityLoadingState extends State<BallCircleOpacityLoading> with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(vsync: this, duration: widget.duration)..repeat();
  late final _animation = _controller.drive(CurveTween(curve: Curves.linear));

  final _opacity = [0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.9, 1.0];
  final List<List<Color>> _colorSchemes = [];

  Color get color => widget.color ?? (Yuro.app.theme ?? const ColorScheme.light()).primary;

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
  Widget build(BuildContext context) => AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final index = (_animation.value * _opacity.length).floor();
        return CustomPaint(painter: _BallPainter(widget.radius, _colorSchemes[index]));
      });
}

class _BallPainter extends CustomPainter {
  final double radius;
  final List<Color> colors;

  _BallPainter(this.radius, this.colors);

  late final _paint = Paint()..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    double perAngle = 2 * pi / colors.length;
    List.generate(colors.length, (index) {
      _paint.color = colors[index];
      canvas.drawCircle(
        Offset(2.5 * radius * cos(perAngle * index), 2.5 * radius * sin(perAngle * index)),
        radius / 2,
        _paint,
      );
    });
  }

  @override
  bool shouldRepaint(covariant _BallPainter old) => radius != old.radius || colors != old.colors;
}
