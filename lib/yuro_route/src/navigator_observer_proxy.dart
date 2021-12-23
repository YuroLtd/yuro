import 'package:flutter/material.dart';

class NavigatorObserverProxy {
  void Function(Route<dynamic> route, Route<dynamic>? previousRoute)? didPush;

  void Function(Route<dynamic>? newRoute, Route<dynamic>? oldRoute)? didReplace;

  void Function(Route<dynamic> route, Route<dynamic>? previousRoute)? didRemove;

  void Function(Route<dynamic> route, Route<dynamic>? previousRoute)? didPop;

  NavigatorObserverProxy({this.didPush, this.didReplace, this.didRemove, this.didPop});

  NavigatorObserverProxy.all(VoidCallback callback) {
    didPush = (_, __) => callback();
    didReplace = (_, __) => callback();
    didRemove = (_, __) => callback();
    didPop = (_, __) => callback();
  }
}
