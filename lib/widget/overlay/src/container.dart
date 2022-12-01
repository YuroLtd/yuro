import 'package:flutter/material.dart';
import 'package:yuro/core/core.dart';

import 'theme.dart';

class OverlayContainer extends StatefulWidget {
  const OverlayContainer(this.theme, this.child, this.disposer, {super.key});

  final OverlayTheme theme;
  final Widget child;
  final Disposer disposer;

  @override
  State<OverlayContainer> createState() => OverlayContainerState();
}

class OverlayContainerState extends State<OverlayContainer>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  Duration get _animationDuration => widget.theme.animationDuration;

  late final _animController = AnimationController(
    vsync: this,
    duration: _animationDuration,
    reverseDuration: _animationDuration,
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    Future.delayed(const Duration(milliseconds: 30), () => _animTo(1.0));
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _animController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _animTo(double value) {
    if (!mounted) return;
    if (value == 0) {
      _animController.animateTo(value, duration: _animationDuration, curve: widget.theme.animationCurve);
    } else {
      _animController.animateBack(value, duration: _animationDuration, curve: widget.theme.animationCurve);
    }
  }

  void dismiss() => _animTo(0);

  EdgeInsets get _margin {
    final viewInsets = MediaQuery.of(context).viewInsets;
    return EdgeInsets.only(bottom: viewInsets.bottom) + widget.theme.margin;
  }

  @override
  Widget build(BuildContext context) {
    final content = AnimatedAlign(
        alignment: widget.theme.alignment,
        duration: _animationDuration,
        curve: widget.theme.animationCurve,
        child: AnimatedPadding(
            padding: _margin,
            duration: _animationDuration,
            curve: widget.theme.animationCurve,
            child: AnimatedBuilder(
              animation: _animController,
              builder: (context, child) => widget.theme.animationBuilder.call(context, _animController, widget.child),
            )));

    if (widget.theme is ToastTheme) return content;

    return Stack(children: [
      Positioned.fill(
        child: GestureDetector(
          onTap: widget.disposer,
          child: ColoredBox(color: widget.theme.color),
        ),
      ),
      content
    ]);
  }
}
