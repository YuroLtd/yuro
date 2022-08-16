// ignore_for_file: overridden_fields

import 'package:flutter/material.dart';
import 'package:yuro/router/router.dart';

/// 页面路由
class YuroPageRoute<T> extends PageRoute<T> with YuroPageRouteMixin<T> {
  YuroPageRoute({
    required this.page,
    super.settings,
    this.maintainState = true,
    this.fullscreenDialog = false,
    this.barrierColor,
    this.barrierLabel,
    this.transitionDuration = const Duration(milliseconds: 300),
    this.reverseTransitionDuration = const Duration(milliseconds: 300),
    this.opaque = true,
    this.barrierDismissible = false,
  });

  final YuroPage page;

  @override
  final bool maintainState;

  @override
  final bool fullscreenDialog;

  @override
  final Color? barrierColor;

  @override
  final String? barrierLabel;

  @override
  final Duration transitionDuration;

  @override
  final Duration reverseTransitionDuration;

  @override
  final bool opaque;

  @override
  final bool barrierDismissible;

  MiddlewareRunner get middlewareRunner => MiddlewareRunner(page.middlewares);

  @override
  String get debugLabel => '${super.debugLabel}(${settings.name})';

  Widget? _child;

  @override
  Widget buildContent(BuildContext context) {
    if (_child == null) {
      final resultBuilder = middlewareRunner.runPageBuildStart(page.builder);
      _child = middlewareRunner.runPageBuildEnd(resultBuilder.call());
    }
    return _child!;
  }

  @override
  void dispose() {
    super.dispose();
    middlewareRunner.runPageDispose(page);
  }
}

mixin YuroPageRouteMixin<T> on PageRoute<T> {
  @protected
  Widget buildContent(BuildContext context);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    final content = buildContent(context);
    return Semantics(scopesRoute: true, explicitChildNodes: true, child: content);
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return Theme.of(context)
        .pageTransitionsTheme
        .buildTransitions<T>(this, context, animation, secondaryAnimation, child);
  }

  @override
  bool canTransitionTo(TransitionRoute<dynamic> nextRoute) {
    return nextRoute is YuroPageRouteMixin && !nextRoute.fullscreenDialog;
  }
}
