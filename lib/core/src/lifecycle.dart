import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';

mixin YuroLifeCycleMixin {
  bool _initialized = false;

  bool get initialized => _initialized;

  bool _destroyed = false;

  bool get destroyed => _destroyed;

  @mustCallSuper
  void onInit() {
    if (_initialized) return;
    _initialized = true;
    onInit();
    SchedulerBinding.instance.addPostFrameCallback((_) => onReady());
  }

  void onReady() {}

  @mustCallSuper
  void onDispose() {
    if (_destroyed) return;
    _destroyed = true;
    onDispose();
  }
}
