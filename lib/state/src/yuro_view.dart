import 'package:flutter/material.dart';

import 'binder/binder.dart';
import 'yuro_controller.dart';

abstract class YuroView<T extends YuroController> extends StatelessWidget {
  const YuroView({super.key});

  final String? tag = null;

  T createController();

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
        child: Builder(builder: (context) => builder.call(context, _controller(context))),
      );

  Widget builder(BuildContext context, T controller);
}

abstract class YuroKeepAliveView<T extends YuroController> extends StatefulWidget {
  const YuroKeepAliveView({super.key});

  String get tag;

  T createController();

  Widget builder(BuildContext context, T controller);

  @override
  // ignore: library_private_types_in_public_api
  _YuroKeepAliveState createState() => _YuroKeepAliveState();
}

class _YuroKeepAliveState<T extends YuroController> extends State<YuroKeepAliveView<T>>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  T _controller(BuildContext context) {
    final inheritedElement = context.getElementForInheritedWidgetOfExactType<Binder<T>>() as BinderElement<T>?;
    if (inheritedElement == null) {
      throw BinderError(controller: '$T', tag: widget.tag);
    }
    context.dependOnInheritedElement(inheritedElement);
    return inheritedElement.controller;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Binder<T>(
      tag: widget.tag,
      init: widget.createController,
      child: Builder(builder: (context) => widget.builder.call(context, _controller(context))),
    );
  }
}
