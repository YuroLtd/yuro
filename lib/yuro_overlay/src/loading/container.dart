part of 'loading.dart';

class _LoadingContainer extends StatefulWidget {
  final UniqueKey uniqueKey;
  final LoadingTheme theme;
  final VoidCallback? onDismiss;

  const _LoadingContainer(this.uniqueKey, this.theme, this.onDismiss);

  @override
  __LoadingContainerState createState() => __LoadingContainerState();
}

class __LoadingContainerState extends State<_LoadingContainer> {
  // 用于界面切换后,取消loading
  late final proxy = NavigatorObserverProxy.all(dismiss);

  @override
  void initState() {
    super.initState();
    YuroNavigatorObserver.register(proxy);
  }

  void dismiss() {
    widget.onDismiss?.call();
    Yuro.dismissLoading(widget.uniqueKey);
  }

  @override
  void dispose() {
    YuroNavigatorObserver.unRegister(proxy);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Container(
        color: widget.theme.barrierColor,
        alignment: Alignment.center,
        child: widget.theme.loadingWidget,
      );
}
