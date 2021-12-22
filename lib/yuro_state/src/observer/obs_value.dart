import 'package:flutter/material.dart';

extension ObsExt<T> on T {
  ValueNotifier<T> get obs => ValueNotifier<T>(this);
}

class Obs<T> extends StatefulWidget {
  const Obs({Key? key, required this.valueListenable, required this.builder, this.child}) : super(key: key);

  final ValueNotifier<T> valueListenable;

  final ValueWidgetBuilder<T> builder;

  final Widget? child;

  @override
  State<StatefulWidget> createState() => _ObsState<T>();
}

class _ObsState<T> extends State<Obs<T>> {
  late T value;

  @override
  void initState() {
    super.initState();
    value = widget.valueListenable.value;
    widget.valueListenable.addListener(_valueChanged);
  }

  @override
  void didUpdateWidget(covariant Obs<T> oldWidget) {
    if (oldWidget.valueListenable != widget.valueListenable) {
      oldWidget.valueListenable.removeListener(_valueChanged);
      value = widget.valueListenable.value;
      widget.valueListenable.addListener(_valueChanged);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    widget.valueListenable.removeListener(_valueChanged);
    super.dispose();
  }

  void _valueChanged() => setState(() => value = widget.valueListenable.value);

  @override
  Widget build(BuildContext context) => widget.builder(context, value, widget.child);
}
