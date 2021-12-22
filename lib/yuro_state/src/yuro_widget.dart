import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'yuro_controller.dart';

abstract class YuroWidget<T extends YuroController> extends StatelessWidget {
  const YuroWidget({Key? key}) : super(key: key);

  Widget builder(BuildContext context, T controller);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider<T>.value(
    value: context.read<T>(),
    builder: (context, child) => builder(context, context.read<T>()),
  );
}