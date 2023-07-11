import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yuro/core/interface.dart';
import 'package:yuro/utils/platform.dart';

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
      indicator = const CircularProgressIndicator(strokeWidth: 3,color: Colors.white);
    }
    return Container(
      padding: EdgeInsets.all(radius),
      decoration: BoxDecoration(
        color: Colors.black45,
        borderRadius: BorderRadius.circular(radius/2),
      ),
      child: SizedBox.fromSize(size: Size.fromRadius(radius), child: indicator),
    );
  }
}
