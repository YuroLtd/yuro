import 'package:flutter/scheduler.dart';

abstract class YuroLifeCycle {
  bool _initialized = false;

  bool get initialized => _initialized;

  bool _destroyed = false;

  bool get destroyed => _destroyed;

  YuroLifeCycle() {
    _init();
  }

  void _init() async {
    if (_initialized) return;
    _initialized = true;
    await onInit();
    SchedulerBinding.instance.addPostFrameCallback((_) => onReady());
  }

  Future<void> onInit() async {}

  void onReady() {}

  void dispose() {
    if (_destroyed) return;
    _destroyed = true;
  }
}
