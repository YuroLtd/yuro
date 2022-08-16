import 'package:flutter/widgets.dart';

import '../yuro_controller.dart';

mixin LifeCycleControllerMixin on LifeCycleController {
  @override
  void onInit() {
    WidgetsBinding.instance.addObserver(this);
    super.onInit();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        onResumed();
        break;
      case AppLifecycleState.inactive:
        onInactive();
        break;
      case AppLifecycleState.paused:
        onPaused();
        break;
      case AppLifecycleState.detached:
        onDetached();
        break;
    }
  }

  void onResumed() {}

  void onPaused() {}

  void onInactive() {}

  void onDetached() {}
}
