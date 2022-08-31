import 'package:flutter/material.dart';

import 'theme.dart';

class OverlayContainer extends StatefulWidget {
  const OverlayContainer({super.key, required this.theme, required this.child});

  final OverlayTheme theme;
  final Widget child;

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
    return EdgeInsets.only(bottom: viewInsets.bottom) + (widget.theme.margin ?? EdgeInsets.zero);
  }

  @override
  Widget build(BuildContext context) => AnimatedAlign(
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
}
