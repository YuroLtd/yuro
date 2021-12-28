import 'package:flutter/material.dart';
import 'package:yuro/yuro_util/src/list.dart';

class YuroWidgetsBindingObserver with WidgetsBindingObserver {
  static final YuroWidgetsBindingObserver _instance = YuroWidgetsBindingObserver._();

  factory YuroWidgetsBindingObserver() => _instance;

  YuroWidgetsBindingObserver._() {
    WidgetsBinding.instance!.addObserver(this);
  }

  final _popRouteListeners = <UniqueKey, ValueGetter<bool>>{};

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
