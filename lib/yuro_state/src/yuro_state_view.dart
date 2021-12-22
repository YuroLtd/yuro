import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'yuro_controller.dart';

abstract class YuroStateView<T extends YuroController> extends StatefulWidget {
  const YuroStateView({Key? key}) : super(key: key);

  T createController();

  bool get wantKeepAlive => false;

  void initState() {}

  void dispose() {}

  Widget builder(BuildContext context, T controller);

  @override
  _YuroStateViewState createState() => _YuroStateViewState();
}

class _YuroStateViewState<T extends YuroController> extends State<YuroStateView<T>> with AutomaticKeepAliveClientMixin {
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
  bool get wantKeepAlive => widget.wantKeepAlive;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
        create: (_) => widget.createController(),
        builder: (context, child) => widget.builder(context, context.read<T>()));
  }
}
