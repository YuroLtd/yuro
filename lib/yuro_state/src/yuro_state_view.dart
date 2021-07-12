import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'yuro_controller.dart';

abstract class YuroStateView<T extends YuroController> extends StatefulWidget {
  void initState() {}

  void dispose() {}

  T createController();

  Widget builder(BuildContext context, T controller);

  @override
  _YuroStateViewState createState() => _YuroStateViewState();
}

class _YuroStateViewState<T extends YuroController> extends State<YuroStateView<T>> {

  @override
  void initState() {
    widget.initState();
    super.initState();
  }

  @override
  void dispose() {
    widget.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (_) => widget.createController(),
      builder: (context, child) => widget.builder(context, context.read<T>()));
}
