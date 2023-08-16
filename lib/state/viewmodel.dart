import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import 'lifecycle.dart';

abstract class BaseViewModel extends YuroLifeCycle with ChangeNotifier, WidgetsBindingObserver {
  BaseViewModel(this.context);

  final BuildContext context;

  @override
  void onInit() {
    WidgetsBinding.instance.addObserver(this);
    super.onInit();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.inactive:
        inactive();
        break;
      case AppLifecycleState.resumed:
        onResumed();
        break;
      case AppLifecycleState.paused:
        onPaused();
        break;
      case AppLifecycleState.detached:
        detached();
        break;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void inactive() {}

  void onResumed() {}

  void onPaused() {}

  void detached() {}
}

abstract class ViewModel extends BaseViewModel {
  ViewModel(super.context, this.state);

  final GoRouterState state;

  Map<String, String> get pathParameters => state.pathParameters;

  String? pathParam(String key) => pathParameters[key];

  Map<String, String> get queryParameters => state.uri.queryParameters;

  String? queryParam(String key) => queryParameters[key];

  Map<String, List<String>> get queryParametersAll => state.uri.queryParametersAll;

  List<String>? queryParamAll(String key) => queryParametersAll[key];

  T? extra<T>() => state.extra as T?;
}
