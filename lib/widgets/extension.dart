import 'package:flutter/material.dart';

extension PositionedExt on Widget {
  Positioned positioned({double? left, double? right, double? top, double? bottom, double? width, double? height}) =>
      Positioned(left: left, right: right, top: top, bottom: bottom, width: width, height: height, child: this);

  Positioned positionedFill({double? left = 0.0, double? top = 0.0, double? right = 0.0, double? bottom = 0.0}) =>
      Positioned.fill(left: left, right: right, top: top, bottom: bottom, child: this);

  Expanded expanded([int flex = 1]) => Expanded(flex: flex, child: this);

  Padding padding(EdgeInsetsGeometry padding) => Padding(padding: padding, child: this);

  Padding paddingAll(double value) => Padding(padding: EdgeInsets.all(value), child: this);

  Padding paddingOnly({double left = 0.0, double top = 0.0, double right = 0.0, double bottom = 0.0}) =>
      Padding(padding: EdgeInsets.only(left: left, right: right, top: top, bottom: bottom), child: this);

  Padding paddingSymmetric({double vertical = 0.0, double horizontal = 0.0}) =>
      Padding(padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical), child: this);

  Center center() => Center(child: this);

  Align align(Alignment alignment) => Align(alignment: alignment, child: this);

  Visibility visibility(bool visible) => Visibility(visible: visible, child: this);

  Offstage offstage(bool offstage) => Offstage(offstage: offstage, child: this);

  SizedBox size(double width, double height) => SizedBox(width: width, height: height, child: this);

  SizedBox square(double? dimension) => SizedBox.square(dimension: dimension, child: this);

  SizedBox width(double width) => SizedBox(width: width, child: this);

  SizedBox height(double height) => SizedBox(height: height, child: this);

  ConstrainedBox constrained(BoxConstraints constraints) => ConstrainedBox(constraints: constraints, child: this);

  AspectRatio aspectRatio(double aspectRatio) => AspectRatio(aspectRatio: aspectRatio, child: this);
}
