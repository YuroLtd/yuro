import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:yuro/state/viewmodel.dart';

abstract class YuroView<T extends BaseViewModel> extends StatelessWidget {
  const YuroView(this.state, {super.key});

  final GoRouterState state;

  T createViewModel(BuildContext context);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: createViewModel,
        builder: (context, child) => builder(context, Provider.of<T>(context), child),
        child: builderChild(context),
      );

  Widget builder(BuildContext context, T viewModel, Widget? child);

  Widget? builderChild(BuildContext context) => null;
}

abstract class YuroViewWithoutState<T extends BaseViewModel> extends StatelessWidget {
  const YuroViewWithoutState({super.key});

  T createViewModel(BuildContext context);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: createViewModel,
        builder: (context, child) => builder(context, Provider.of<T>(context), child),
        child: builderChild(context),
      );

  Widget builder(BuildContext context, T viewModel, Widget? child);

  Widget? builderChild(BuildContext context) => null;
}

abstract class YuroKeepAliveView<T extends ViewModel> extends StatefulWidget {
  const YuroKeepAliveView(this.state, {super.key});

  final GoRouterState state;

  T createViewModel(BuildContext context);

  void initState() {}

  void dispose() {}

  Widget builder(BuildContext context, T viewModel, Widget? child);

  Widget? builderChild(BuildContext context) => null;

  @override
  YuroKeepAliveViewState createState() => YuroKeepAliveViewState();
}

class YuroKeepAliveViewState<T extends ViewModel> extends State<YuroKeepAliveView<T>> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    widget.initState();
  }

  @override
  void dispose() {
    widget.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
      create: (context) => widget.createViewModel(context),
      builder: (context, child) => widget.builder(context, Provider.of<T>(context), child),
      child: widget.builderChild(context),
    );
  }
}

/// 父组件要求是[YuroView]
abstract class YuroWidget<T extends BaseViewModel> extends StatelessWidget {
  const YuroWidget({super.key});

  @override
  Widget build(BuildContext context) => Consumer<T>(builder: builder, child: builderChild(context));

  Widget builder(BuildContext context, T viewModel, Widget? child);

  Widget? builderChild(BuildContext context) => null;
}