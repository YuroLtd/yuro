import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';

abstract class YuroLifeCycle {
  YuroLifeCycle() {
    onInit();
  }

  @mustCallSuper
  void onInit() {
    SchedulerBinding.instance?.addPostFrameCallback((_) => onReady());
  }

  @mustCallSuper
  void onReady() {}

  @mustCallSuper
  void dispose() {}
}
