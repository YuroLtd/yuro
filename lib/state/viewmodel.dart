import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import 'lifecycle.dart';

abstract class ViewModel extends YuroLifeCycle with ChangeNotifier {
  ViewModel(this.context, this.state);

  final BuildContext context;
  final GoRouterState state;

  String? pathParam(String key) => state.pathParameters[key];

  String? queryParam(String key) => state.queryParameters[key];

  List<String>? queryParamAll(String key) => state.queryParametersAll[key];

  T? extra<T>() => state.extra as T?;
}
