import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import 'lifecycle.dart';

abstract class BaseViewModel extends YuroLifeCycle with ChangeNotifier {
  BaseViewModel(this.context);

  final BuildContext context;
}

abstract class ViewModel extends BaseViewModel {
  ViewModel(super.context, this.state);

  final GoRouterState state;

  Map<String, String> get pathParameters => state.pathParameters;

  String? pathParam(String key) => pathParameters[key];

  Map<String, String> get queryParameters => state.queryParameters;

  String? queryParam(String key) => queryParameters[key];

  Map<String, List<String>> get queryParametersAll => state.queryParametersAll;

  List<String>? queryParamAll(String key) => queryParametersAll[key];

  T? extra<T>() => state.extra as T?;
}
