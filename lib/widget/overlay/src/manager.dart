import 'dart:async';

import 'package:flutter/material.dart';
import 'package:yuro/core/core.dart';
import 'package:yuro/router/router.dart';

import 'container.dart';
import 'theme.dart';

class OverlayManager {
  //
  final _futures = <GlobalKey, OverlayFuture>{};

  // 排除ToastOverlay
  List<OverlayFuture> get overlaies => _futures.values.where((element) => !element.isToastOverlay).toList();

  //
  OverlayTheme? _overlayTheme;

  OverlayTheme get overlayTheme => _overlayTheme ?? OverlayTheme();

  set overlayTheme(OverlayTheme theme) => _overlayTheme = theme;

  //
  ToastTheme? _toastTheme;

  ToastTheme get toastTheme => _toastTheme ?? ToastTheme();

  set toastTheme(ToastTheme theme) => _toastTheme = theme;

  //
  LoadingTheme? _loadingTheme;

  LoadingTheme get loadingTheme => _loadingTheme ?? LoadingTheme();

  set loadingTheme(LoadingTheme theme) => _loadingTheme = theme;

  void addOverlay(GlobalKey key, OverlayFuture future) {
    _futures[key] = future;
    Yuro.navigator.overlay?.insert(future.overlayEntry);
  }

  void removeOverlay([GlobalKey? key]) {
    key ??= _futures.values.lastWhere((element) => !element.isToastOverlay).globalKey;
    _futures.remove(key)?.dismiss();
  }
}

class OverlayFuture {
  final OverlayEntry overlayEntry;
  final GlobalKey<OverlayContainerState> globalKey;
  final Duration animationDuration;
  final bool isToastOverlay;
  final VoidCallback? onDismiss;

  Timer? timer;

  OverlayFuture({
    required this.globalKey,
    required this.overlayEntry,
    required this.animationDuration,
    required this.isToastOverlay,
    this.onDismiss,
  });

  void dismiss() {
    timer?.cancel();
    globalKey.currentState?.dismiss();
    // 延迟[animationDuration]是为了保证退出动画执行完,而不是立即结束
    Future.delayed(animationDuration, overlayEntry.remove).whenComplete(() => onDismiss?.call());
  }
}
