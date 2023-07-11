import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GoRouterConfig {
  final GoRouterPageBuilder? errorPageBuilder;
  final GoRouterWidgetBuilder? errorBuilder;
  final GoRouterRedirect? redirect;
  final Listenable? refreshListenable;
  final int redirectLimit;
  final bool routerNeglect;
  final String? initialLocation;
  final Object? initialExtra;
  final List<NavigatorObserver> observers;
  final bool debugLogDiagnostics;
  final GlobalKey<NavigatorState>? navigatorKey;
  final String? restorationScopeId;

  GoRouterConfig({
    this.errorPageBuilder,
    this.errorBuilder,
    this.redirect,
    this.refreshListenable,
    this.redirectLimit = 5,
    this.routerNeglect = false,
    this.initialLocation,
    this.initialExtra,
    this.observers = const [],
    this.debugLogDiagnostics = kDebugMode,
    this.navigatorKey,
    this.restorationScopeId,
  });

  GoRouterConfig merge(GoRouterConfig? other) => GoRouterConfig(
        errorPageBuilder: other?.errorPageBuilder ?? errorPageBuilder,
        errorBuilder: other?.errorBuilder ?? errorBuilder,
        redirect: other?.redirect ?? redirect,
        refreshListenable: other?.refreshListenable ?? refreshListenable,
        redirectLimit: other?.redirectLimit ?? redirectLimit,
        routerNeglect: other?.routerNeglect ?? routerNeglect,
        initialLocation: other?.initialLocation ?? initialLocation,
        initialExtra: other?.initialExtra ?? initialExtra,
        observers: observers..addAll(other?.observers ?? []),
        debugLogDiagnostics: other?.debugLogDiagnostics ?? debugLogDiagnostics,
        navigatorKey: other?.navigatorKey ?? navigatorKey,
        restorationScopeId: other?.restorationScopeId ?? restorationScopeId,
      );
}
