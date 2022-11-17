import 'package:flutter/material.dart';
import 'package:yuro/state/state.dart';

enum ViewState { loading, failed, empty, success, search }

class StateView extends StatelessWidget {
  final ObjectNotifier<ViewState> viewState;
  final VoidCallback? onRefresh;
  final Widget? loadingView;
  final Widget? failedView;
  final Widget? emptyView;
  final Widget content;
  final Widget? searchView;

  const StateView({
    Key? key,
    required this.viewState,
    this.onRefresh,
    required this.content,
    this.loadingView,
    this.failedView,
    this.emptyView,
    this.searchView,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ObsValue<ViewState>(
      notifier: viewState,
      builder: (state, child) => IndexedStack(index: state.index, children: [
            loadingView ?? Container(),
            failedView ?? Container(),
            emptyView ?? Container(),
            content,
            searchView ?? Container()
          ]));
}
