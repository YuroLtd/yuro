import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yuro/utils/screen.dart';

abstract class YuroInterface {
  /// go_router
  late GoRouter router;

  /// 事件总线
  late final broadcast = StreamController.broadcast();

  /// SharedPreferences
  late final SharedPreferences sp;

  late Screen screen;
}

class _YuroImpl extends YuroInterface {
  GlobalKey<NavigatorState> get navigatorKey => router.routerDelegate.navigatorKey;

  BuildContext get currentContext => navigatorKey.currentContext!;

  NavigatorState get currentState => navigatorKey.currentState!;

  /// 关闭软键盘
  void unFocus({UnfocusDisposition disposition = UnfocusDisposition.scope}) {
    FocusManager.instance.primaryFocus?.unfocus(disposition: disposition);
  }
}

// ignore: non_constant_identifier_names
final Yuro = _YuroImpl();
