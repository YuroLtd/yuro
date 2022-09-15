import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';

mixin YuroLifeCycleMixin {
  bool _initialized = false;

  bool get initialized => _initialized;

  bool _destroyed = false;

  bool get destroyed => _destroyed;

  @nonVirtual
  void onCreate() {
    if (_initialized) return;
    onInit();
    SchedulerBinding.instance.addPostFrameCallback((_) => onReady());
    _initialized = true;
  }

  @nonVirtual
  void onDestroy() {
    if (_destroyed) return;
    onDispose();
    _destroyed = true;
  }

  void onInit() {}

  void onReady() {}

  void onDispose() {}
}
