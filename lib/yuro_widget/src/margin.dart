import 'package:flutter/material.dart';

/// Margin组件,与[Padding]组件相对应
class Margin extends StatelessWidget {
  final EdgeInsets margin;
  final Widget? child;

  const Margin({Key? key, required this.margin, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(margin: margin, child: child);
}
