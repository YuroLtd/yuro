import 'package:flutter/material.dart';

import 'binder/binder.dart';
import 'yuro_controller.dart';

abstract class YuroView<T extends YuroController> extends StatelessWidget {
  const YuroView({super.key});

  final String? tag = null;

  T createController();

  void initState() {}

  void didChangeDependencies() {}

  void didUpdateWidget(Binder<T> oldWidget, BinderElement<T> state) {}

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
        init: createController,
        //
        initState: initState,
        didChangeDependencies: didChangeDependencies,
        didUpdateWidget: didUpdateWidget,
        dispose: dispose,
        //
        child: Builder(builder: (context) => builder.call(context, _controller(context))),
      );

  Widget builder(BuildContext context, T controller);

  void dispose() {}
}
