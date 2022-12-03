import 'package:flutter/material.dart';

import 'binder/binder.dart';
import 'yuro_controller.dart';

abstract class YuroView<T extends YuroController> extends StatelessWidget {
  const YuroView({super.key});

  final String? tag = null;

  T createController();

  void didChangeDependencies(BuildContext context, T controller) {}

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
        didChangeDependencies: didChangeDependencies,
        child: Builder(builder: (context) => builder.call(context, _controller(context))),
      );

  Widget builder(BuildContext context, T controller);
}
