import 'package:flutter/material.dart';

abstract class YuroRoute {
  String get initialRoute;

  Map<String, Route> get routes => {};

  Route? onGenerateRoute(RouteSettings settings) {
    return null;
  }

  Route? onUnknownRoute(RouteSettings settings) {
    return null;
  }
}
