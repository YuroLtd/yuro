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

  OverlayTheme get overlayTheme =>
      _overlayTheme ??
      OverlayTheme(
          alignment: Alignment.center,
          animationBuilder: (context, controller, child) => ScaleTransition(
                scale: controller,
                child: Opacity(opacity: controller.value, child: child),
              ));

  set overlayTheme(OverlayTheme theme) => _overlayTheme = theme;

  //
  ToastTheme? _toastTheme;

  ToastTheme get toastTheme =>
      _toastTheme ??
      ToastTheme(
          textStyle: const TextStyle(),
          alignment: Alignment.bottomCenter,
          margin: EdgeInsets.only(bottom: 0.33.sh),
          animationBuilder: (context, controller, child) => ScaleTransition(
              scale: controller,
              child: Opacity(
                  opacity: controller.value,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.w),
                    decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(5.w)),
                    child: child,
                  ))));

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
