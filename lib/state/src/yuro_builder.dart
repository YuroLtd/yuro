import 'package:flutter/widgets.dart';
import 'package:yuro/util/util.dart';

import 'binder/binder.dart';
import 'yuro_controller.dart';

class YuroBuilder<T extends YuroController> extends StatelessWidget {
  final String? tag;
  final Widget Function(T controller) builder;

  final T? init;
  final VoidCallback? initState, dispose, didChangeDependencies;
  final void Function(Binder<T> oldWidget, BinderElement<T> state)? didUpdateWidget;

  const YuroBuilder({
    super.key,
    this.tag,
    this.init,
    //
    this.initState,
    this.didChangeDependencies,
    this.didUpdateWidget,
    this.dispose,
    //
    required this.builder,
  });

  T _controller(BuildContext context) {
    final inheritedElement = context.getElementForInheritedWidgetOfExactType<Binder<T>>() as BinderElement<T>?;
    if (inheritedElement == null) {
      throw BinderError(controller: '$T', tag: tag);
    }
    context.dependOnInheritedElement(inheritedElement);
    return inheritedElement.controller;
  }

  @override
  Widget build(BuildContext context) => Binder<T>(
        tag: tag,
        init: init.isNull ? null : () => init!,
        //
        initState: initState,
        didChangeDependencies: didChangeDependencies,
        didUpdateWidget: didUpdateWidget,
        dispose: dispose,
        //
        child: Builder(builder: (context) => builder.call(_controller(context))),
      );
}
