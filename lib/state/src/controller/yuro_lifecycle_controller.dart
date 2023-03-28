import 'package:flutter/material.dart';
import 'package:yuro/router/router.dart';
import 'package:yuro/util/util.dart';
import 'yuro_controller.dart';

abstract class YuroLifecycleController extends YuroController with WidgetsBindingObserver implements PageAware {
  @override
  void onInit() {
    WidgetsBinding.instance.addObserver(this);
    if (pageSettings.notNull) YuroPageObserver.register(pageSettings!, this);
    super.onInit();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.detached:
        detached();
        break;
      case AppLifecycleState.inactive:
        inactive();
        break;
      case AppLifecycleState.resumed:
        onResumed();
        break;
      case AppLifecycleState.paused:
        onPaused();
        break;
    }
  }

  @override
  void onDispose() {
    WidgetsBinding.instance.removeObserver(this);
    if (pageSettings.notNull) YuroPageObserver.unRegister(pageSettings!, this);
    super.onDispose();
  }

  void inactive() {}

  void onResumed() {
    onPageShow();
  }

  void onPaused() {
    onPageHide();
  }

  void detached() {}

  @override
  void didPopNext() {
    onPageShow();
  }

  @override
  void didPush() {}

  @override
  void didPop() {}

  @override
  void didPushNext() {
    onPageHide();
  }

  void onPageShow() {}

  void onPageHide() {}
}
