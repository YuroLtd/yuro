import 'dart:async';

import 'package:flutter/material.dart';
import 'package:yuro/yuro_core/yuro_core.dart';
import 'package:yuro/yuro_route/yuro_route.dart';

part 'container.dart';

part 'theme.dart';

extension YuroToastExt on YuroInterface {
  static ToastTheme _toastTheme = ToastTheme();

  set toastTheme(ToastTheme newTheme) => _toastTheme = newTheme;

  void showToast(String text, {ToastTheme? theme}) {
    final currentTheme = theme ?? _toastTheme;
    final widget = Container(
      margin: const EdgeInsets.only(bottom: 50),
      padding: currentTheme.padding,
      decoration: BoxDecoration(
        color: currentTheme.backgroundColor,
        borderRadius: BorderRadius.circular(currentTheme.radius),
      ),
      child: ClipRect(child: DefaultTextStyle(style: currentTheme.style, child: Text(text))),
    );
    showToastWidget(child: widget, theme: currentTheme);
  }

  void showToastWidget({required Widget child, ToastTheme? theme, VoidCallback? onDismiss}) {
    final currentTheme = theme ?? _toastTheme;
    if (currentTheme.onlyOne) _ToastManager().dismissAll();
    final containerKey = GlobalKey<_ToastContainerState>();
    final overlayEntry = OverlayEntry(
      builder: (context) => _ToastContainer(currentTheme, child, key: containerKey),
    );
    final future = _ToastFuture(overlayEntry, onDismiss, containerKey, currentTheme.animationDuration);
    future.timer = Timer(currentTheme.duration, future.dismiss);
    Yuro.currentState.overlay?.insert(overlayEntry);
    _ToastManager().add(future);
  }
}

class _ToastManager {
  static late final _ToastManager _instance = _ToastManager._();

  _ToastManager._();

  factory _ToastManager() => _instance;

  final Set<_ToastFuture> _set = {};

  void add(_ToastFuture future) => _set.add(future);

  void remove(_ToastFuture future) => _set.remove(future);

  void dismissAll() => _set.toList().forEach((element) => element.dismiss(false));
}

class _ToastFuture {
  _ToastFuture(this.entry, this.onDismiss, this.containerKey, this.animationDuration);

  final OverlayEntry entry;
  final VoidCallback? onDismiss;
  final GlobalKey<_ToastContainerState> containerKey;
  final Duration animationDuration;

  Timer? timer;

  void dismiss([bool anim = true]) {
    if (anim) {
      containerKey.currentState?.dismiss();
      Future.delayed(animationDuration, entry.remove);
    } else {
      entry.remove();
    }
    timer?.cancel();
    _ToastManager().remove(this);
    onDismiss?.call();
  }
}
