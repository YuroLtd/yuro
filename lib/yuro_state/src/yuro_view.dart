import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'yuro_controller.dart';

abstract class YuroView<T extends YuroController> extends StatelessWidget {
  T createController();

  Widget builder(BuildContext context, T controller);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (_) => createController(),
        builder: (context, child) => builder(context, context.read<T>()),
      );
}

abstract class YuroWidget<T extends YuroController> extends StatelessWidget {
  Widget builder(BuildContext context, T controller);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider<T>.value(
    value: context.read<T>(),
    builder: (context, child) => builder(context, context.read<T>()),
  );
}