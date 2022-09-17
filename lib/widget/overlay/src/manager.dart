import 'dart:async';

import 'package:flutter/material.dart';
import 'package:yuro/util/util.dart';

import 'container.dart';
import 'theme.dart';

class OverlayManager {
  //
  final _futures = <GlobalKey, OverlayFuture>{};

  //
  OverlayTheme? _overlayTheme;

  OverlayTheme get overlayTheme => _overlayTheme ?? OverlayTheme();

  set overlayTheme(OverlayTheme theme) => _overlayTheme = theme;

  //
  ToastTheme? _toastTheme;

  ToastTheme get toastTheme => _toastTheme ?? ToastTheme();

  set toastTheme(ToastTheme theme) => _toastTheme = theme;

  void addOverlay(GlobalKey key, OverlayFuture future) => _futures[key] = future;

  void remove(GlobalKey key) => _futures.remove(key);

  void dismissOverlay([GlobalKey? key]) => (_futures[key] ?? _futures.values.lastOrNull)?.dismiss();
}

class OverlayFuture {
  OverlayFuture({
    required this.manager,
    required this.globalKey,
    required this.overlayEntry,
    required this.animationDuration,
    this.onDismiss,
  });

  final OverlayManager manager;
  final OverlayEntry overlayEntry;
  final GlobalKey<OverlayContainerState> globalKey;
  final Duration animationDuration;
  final VoidCallback? onDismiss;

  Timer? timer;

  void dismiss() {
    timer?.cancel();
    globalKey.currentState?.dismiss();
    Future.delayed(animationDuration, overlayEntry.remove);
    manager.remove(globalKey);
    onDismiss?.call();
  }
}
