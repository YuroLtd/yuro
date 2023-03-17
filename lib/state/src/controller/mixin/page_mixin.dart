part of '../yuro_controller.dart';

mixin PageLifeCycleMixin on YuroController implements PageAware {
  PageSettings? get _pageSettings => _decoder?.settings;

  @override
  void onInit() {
    super.onInit();
    if (_pageSettings.notNull) YuroPageObserver.register(_pageSettings!, this);
  }

  @override
  void onDispose() {
    if (_pageSettings.notNull) YuroPageObserver.unRegister(_pageSettings!, this);
    super.onDispose();
  }

  @override
  void didPopNext() {}

  @override
  void didPush() {}

  @override
  void didPop() {}

  @override
  void didPushNext() {}
}
