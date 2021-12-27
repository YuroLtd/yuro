import 'package:flutter/material.dart';
import 'package:yuro/yuro_core/yuro_core.dart';
import 'package:yuro/yuro_route/yuro_route.dart';
import 'package:yuro/yuro_app/yuro_app.dart';

part 'theme.dart';

part 'container.dart';

extension YuroLoadingExt on YuroInterface {
  static LoadingTheme _loadingTheme = LoadingTheme();

  void changeLoadingTheme(LoadingTheme newTheme) => _loadingTheme = newTheme;

  static OverlayEntry? _loadingEntry;

  UniqueKey? showLoading([VoidCallback? onDismiss]) {
    if (_loadingEntry != null) return null;
    final key = UniqueKey();
    _loadingEntry = OverlayEntry(builder: (context) => _LoadingContainer(key, _loadingTheme, onDismiss));
    Yuro.currentState.overlay?.insert(_loadingEntry!);
    // 当loading显示时,拦截返回按钮事件, 去取消loading弹窗
    YuroWidgetsBindingObserver().addPopRouteListener(key, () {
      onDismiss?.call();
      dismissLoading(key);
      return true;
    });
    return key;
  }

  void dismissLoading([UniqueKey? key]) {
    _loadingEntry?.remove();
    _loadingEntry = null;
    if (key != null) YuroWidgetsBindingObserver().removePopRouteListener(key);
  }
}
