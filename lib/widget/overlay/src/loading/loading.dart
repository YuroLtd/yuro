import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yuro/core/core.dart';
import 'package:yuro/util/util.dart';

export 'ball_circle_opacity.dart';
export 'ring_inside.dart';

class PlatformLoading extends StatelessWidget {
  final double radius;

  const PlatformLoading({this.radius = 15, super.key});
  @override
  Widget build(BuildContext context) {
    Widget indicator;
    if (Yuro.isMacOS || Yuro.isIOS) {
      indicator = const CupertinoActivityIndicator();
    } else {
      indicator = const CircularProgressIndicator(strokeWidth: 3);
    }
    return SizedBox.fromSize(size: Size.fromRadius(radius), child: indicator);
  }
}
