part of 'toast.dart';

class _ToastContainer extends StatefulWidget {
  final ToastTheme theme;
  final Widget child;

  const _ToastContainer(this.theme, this.child, {Key? key}) : super(key: key);

  @override
  _ToastContainerState createState() => _ToastContainerState();
}

class _ToastContainerState extends State<_ToastContainer> with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  EdgeInsets get _bottomOffset => EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom);

  Duration get _animationDuration => widget.theme.animationDuration;

  late final AnimationController _animController = AnimationController(
    vsync: this,
    duration: _animationDuration,
    reverseDuration: _animationDuration,
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
    Future.delayed(Duration(milliseconds: 30), () => _animTo(1.0));
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _animController.dispose();
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  void dismiss() => _animTo(0);

  void _animTo(double value) {
    if (!mounted) return;
    if (value == 0) {
      _animController.animateTo(value, duration: _animationDuration, curve: widget.theme.animationCurve);
    } else {
      _animController.animateBack(value, duration: _animationDuration, curve: widget.theme.animationCurve);
    }
  }

  @override
  Widget build(BuildContext context) => AnimatedAlign(
      alignment: widget.theme.position.alignment,
      duration: _animationDuration,
      curve: widget.theme.animationCurve,
      child: AnimatedPadding(
          padding: widget.theme.position.offset + _bottomOffset,
          duration: _animationDuration,
          curve: widget.theme.animationCurve,
          child: AnimatedBuilder(
              animation: _animController,
              builder: (context, child) => widget.theme.animationBuilder.call(
                    context,
                    _animController,
                    _animController.value,
                    widget.child,
                  ))));
}
