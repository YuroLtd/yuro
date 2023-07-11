import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';

abstract class YuroLifeCycle {
  bool _initialized = false;
  bool _destroyed = false;

  YuroLifeCycle() {
    _init();
  }

  void _init() {
    if (_initialized) return;
    _initialized = true;
    onInit();
  }

  @mustCallSuper
  void onInit() {
    SchedulerBinding.instance.addPostFrameCallback((_) => onReady());
  }

  @mustCallSuper
  void onReady() {}

  @mustCallSuper
  void dispose() {
    if (_destroyed) return;
    _destroyed = true;
  }
}
