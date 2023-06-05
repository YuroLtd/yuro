import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:yuro/state/viewmodel.dart';

abstract class YuroView<T extends ViewModel> extends StatelessWidget {
  const YuroView(this.state, {super.key});

  final GoRouterState state;

  T createViewModel(BuildContext context);

  bool get lazyLoad => true;

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: createViewModel,
        builder: (context, child) => builder(context, Provider.of<T>(context), child),
        lazy: lazyLoad,
        child: child(),
      );

  Widget? child() => null;

  Widget builder(BuildContext context, T viewModel, Widget? child);
}
