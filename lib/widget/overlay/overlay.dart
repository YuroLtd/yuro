import 'dart:async';

import 'package:flutter/material.dart';
import 'package:yuro/core/core.dart';
import 'package:yuro/router/router.dart';

import 'src/container.dart';
import 'src/manager.dart';
import 'src/theme.dart';

export 'src/theme.dart';

extension YuroOverlayExt on YuroInterface {
  static final _overlayManager = OverlayManager();

  set overlayTheme(OverlayTheme theme) => _overlayManager.overlayTheme = theme;

  set toastTheme(ToastTheme theme) => _overlayManager.toastTheme = theme;

  void showToast(String content, {ToastDuration? duration, ToastPosition? position}) {
    position ??= ToastPosition.bottom;
    final theme = _overlayManager.toastTheme.copyWith(
      duration: (duration ?? ToastDuration.long).duration,
      alignment: position.alignment,
      margin: position.margin,
    );
    showOverlay(theme: theme, child: DefaultTextStyle(style: theme.textStyle, child: Text(content)));
  }

  GlobalKey showOverlay({OverlayTheme? theme, required Widget child, VoidCallback? onDismiss}) {
    final globalKey = GlobalKey<OverlayContainerState>();
    final overlayTheme = theme ?? _overlayManager.overlayTheme;
    disposer() {
      if (theme is! ToastTheme) dismissOverlay(globalKey);
    }
    final overlayEntry = OverlayEntry(builder: (context) {
      return OverlayContainer(overlayTheme, child, disposer, key: globalKey);
    });

    final future = OverlayFuture(
        manager: _overlayManager,
        globalKey: globalKey,
        overlayEntry: overlayEntry,
        animationDuration: overlayTheme.animationDuration,
        onDismiss: onDismiss);
    if (overlayTheme.duration != null) {
      future.timer = Timer(overlayTheme.duration!, future.dismiss);
    }
    _overlayManager.addOverlay(globalKey, future);
    Yuro.navigator.overlay?.insert(overlayEntry);
    return globalKey;
  }

  void dismissOverlay([GlobalKey? key]) => _overlayManager.dismissOverlay(key);
}
