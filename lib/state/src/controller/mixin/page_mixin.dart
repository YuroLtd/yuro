part of '../yuro_controller.dart';

mixin PageLifeCycleMixin on YuroController implements WidgetsBindingObserver, PageAware {
  final _logger = Yuro.tag('YuroPageObserver');

  PageSettings? get _pageSettings => _decoder?.settings;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    if (_pageSettings.notNull) YuroPageObserver.register(_pageSettings!, this);
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
    if (_pageSettings.notNull) YuroPageObserver.unRegister(_pageSettings!, this);
    WidgetsBinding.instance.removeObserver(this);
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

  void onPageShow() {
    _logger.v('[show]---->${_pageSettings?.name}');
  }

  void onPageHide() {
    _logger.v('[hide]---->${_pageSettings?.name}');
  }

  @override
  void didChangeAccessibilityFeatures() {}

  @override
  void didChangeLocales(List<Locale>? locales) {}

  @override
  void didChangeMetrics() {}

  @override
  void didChangePlatformBrightness() {}

  @override
  void didChangeTextScaleFactor() {}

  @override
  void didHaveMemoryPressure() {}

  @override
  Future<bool> didPopRoute() => Future<bool>.value(false);

  @override
  Future<bool> didPushRoute(String route) => Future<bool>.value(false);

  @override
  Future<bool> didPushRouteInformation(RouteInformation routeInformation) {
    return didPushRoute(routeInformation.location!);
  }
}
