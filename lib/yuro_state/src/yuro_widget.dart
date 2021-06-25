import 'package:flutter/material.dart';
import 'package:yuro/yuro.dart';

abstract class YuroWidget<T extends YuroController> extends StatelessWidget {
  late final T controller;

  Widget builder(BuildContext context);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider<T>.value(
        value: controller = context.read<T>(),
        builder: (context, child) => builder(context),
      );
}
