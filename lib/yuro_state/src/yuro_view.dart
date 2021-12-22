import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'yuro_controller.dart';

abstract class YuroView<T extends YuroController> extends StatelessWidget {
  const YuroView({Key? key}) : super(key: key);

  T createController();

  Widget builder(BuildContext context, T controller);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (_) => createController(),
        builder: (context, child) => builder(context, context.read<T>()),
      );
}

