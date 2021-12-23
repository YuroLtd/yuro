import 'package:flutter/material.dart';
import 'package:yuro/yuro_extension/src/list.dart';

class YuroWidgetsBindingObserver with WidgetsBindingObserver {
  final _popRouteListeners = <UniqueKey, ValueGetter<bool>>{};

  static final YuroWidgetsBindingObserver _instance = YuroWidgetsBindingObserver._();

  YuroWidgetsBindingObserver._() {
    WidgetsBinding.instance!.addObserver(this);
  }

  factory YuroWidgetsBindingObserver() => _instance;

  void addPopRouteListener(UniqueKey key, ValueGetter<bool> listener) => _popRouteListeners[key] = listener;

  void removePopRouteListener(UniqueKey key) => _popRouteListeners.remove(key);

  @override
  Future<bool> didPopRoute() {
    final clone = _popRouteListeners.values.toList().reverse();
    for (final element in clone) {
      if (element.call()) return Future<bool>.value(true);
    }
    return super.didPopRoute();
  }
}