import 'dart:async';

import 'package:flutter/material.dart';
import 'package:yuro/core/core.dart';
import 'package:yuro/util/util.dart';

import 'src/container.dart';
import 'src/manager.dart';
import 'src/theme.dart';

export 'src/theme.dart';
export 'src/loading/loading.dart';

extension YuroOverlayExt on YuroInterface {
  static final _overlayManager = OverlayManager();

  static GlobalKey? _loadingKey;

  set overlayTheme(OverlayTheme theme) => _overlayManager.overlayTheme = theme;

  set toastTheme(ToastTheme theme) => _overlayManager.toastTheme = theme;

  set loadingTheme(LoadingTheme theme) => _overlayManager.loadingTheme = theme;

  bool hasOverlayShow() => _overlayManager.overlaies.isNotEmpty;

  void showToast(String content, {ToastDuration? duration, ToastPosition? position}) {
    position ??= ToastPosition.bottom;
    final theme = _overlayManager.toastTheme.copyWith(
      duration: duration,
      alignment: position.alignment,
      margin: position.margin,
    );
    showOverlay(
      builder: (_) => Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.w),
        decoration: BoxDecoration(color: theme.color, borderRadius: BorderRadius.circular(5.w)),
        child: DefaultTextStyle(style: theme.textStyle, child: Text(content)),
      ),
      theme: theme,
    );
  }

  void showLoading({Widget? child, LoadingTheme? loadingTheme, VoidCallback? onDismiss}) {
    if (_loadingKey != null) return;
    _loadingKey = showOverlay(
      builder: (_) => child ?? _overlayManager.loadingTheme.child,
      theme: loadingTheme ?? _overlayManager.loadingTheme,
      onDismiss: onDismiss,
    );
  }

  void dismissLoading() {
    if (_loadingKey == null) return;
    dismissOverlay(_loadingKey);
    _loadingKey = null;
  }

  GlobalKey showOverlay({required WidgetBuilder builder, OverlayTheme? theme, VoidCallback? onDismiss}) {
    final globalKey = GlobalKey<OverlayContainerState>();
    theme ??= _overlayManager.overlayTheme;
    // 用于点击空白处弹出Overlay
    disposer() {
      if (theme.runtimeType.toString() == 'OverlayTheme') dismissOverlay(globalKey);
    }

    final overlayEntry = OverlayEntry(builder: (context) {
      return OverlayContainer(theme!, builder.call(context), disposer, key: globalKey);
    });

    final future = OverlayFuture(
      globalKey: globalKey,
      overlayEntry: overlayEntry,
      animationDuration: theme.animationDuration,
      isToastOverlay: theme is ToastTheme,
      onDismiss: onDismiss,
    );

    if (theme is ToastTheme) {
      future.timer = Timer(theme.duration.duration, () => dismissOverlay(globalKey));
    }
    _overlayManager.addOverlay(globalKey, future);
    return globalKey;
  }

  void dismissOverlay([GlobalKey? key]) => _overlayManager.removeOverlay(key);
}
