import 'dart:async';

import 'package:flutter/material.dart';
import 'package:yuro/core/core.dart';
import 'package:yuro/instance/instance.dart';

import '../controller_mixin/ticker_mixin.dart';

typedef InitialBuilder<T> = T Function();

class Binder<T> extends InheritedWidget {
  final String? tag;
  final InitialBuilder<T>? init;

  const Binder({
    super.key,
    required super.child,
    this.tag,
    this.init,
  });

  @override
  bool updateShouldNotify(Binder<T> oldWidget) => tag != oldWidget.tag || init != oldWidget.init;

  @override
  InheritedElement createElement() => BinderElement<T>(this);
}

class BinderElement<T> extends InheritedElement {
  BinderElement(Binder<T> widget) : super(widget) {
    initState();
  }

  InitialBuilder<T>? _controllerBuilder;
  VoidCallback? _remove;
  bool? _isCreator = false;
  var _dirty = false;
  T? _controller;

  @override
  Binder<T> get widget => super.widget as Binder<T>;

  T get controller {
    if (_controller == null) {
      _controller = _controllerBuilder?.call();
      if (_controller == null) {
        throw BinderError(controller: _controller, tag: widget.tag);
      }
      _subscribeController();
    }
    return _controller!;
  }

  void initState() {
    final isRegistered = Yuro.isRegistered<T>(widget.tag);
    if (isRegistered) {
      _isCreator = Yuro.isPrepared<T>(widget.tag);
    } else {
      Yuro.lazyPut<T>(widget.init!, tag: widget.tag);
      _isCreator = true;
    }
    _controllerBuilder = () => Yuro.find<T>(widget.tag);
  }

  void _subscribeController() {
    if (controller is Listenable) {
      _remove?.call();
      (controller as Listenable).addListener(_update);
      _remove = () => (controller as Listenable).removeListener(_update);
    } else if (controller is StreamController) {
      _remove?.call();
      final stream = (controller as StreamController).stream.listen((_) => _update);
      _remove = () => stream.cancel();
    }
  }

  @override
  void update(Binder<T> newWidget) {
    if (widget.tag != newWidget.tag) _subscribeController();
    super.update(newWidget);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (controller is SingleTickerMixin) {
      (controller as SingleTickerMixin).didChangeDependencies(this);
    } else if (controller is TickerMixin) {
      (controller as TickerMixin).didChangeDependencies(this);
    }
  }

  void _update() {
    _dirty = true;
    markNeedsBuild();
  }

  @override
  void notifyClients(Binder<T> oldWidget) {
    super.notifyClients(oldWidget);
    _dirty = false;
  }

  @override
  Widget build() {
    if (_dirty) notifyClients(widget);
    return super.build();
  }

  @override
  void unmount() {
    dispose();
    super.unmount();
  }

  void dispose() {
    if (_isCreator! && Yuro.isRegistered<T>(widget.tag)) {
      Yuro.delete<T>(tag: widget.tag);
    }
    _remove?.call();
    _remove = null;
    _isCreator = null;
    _controllerBuilder = null;
    _controller = null;
  }
}

class BinderError<T> extends Error {
  final T controller;
  final String? tag;

  BinderError({required this.controller, required this.tag});

  @override
  String toString() => '''
     Error: "$controller" with tag "$tag" no found.
      ''';
}
