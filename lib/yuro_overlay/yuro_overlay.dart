library yuro_overlay;

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:yuro/yuro_core/yuro_core.dart';
import 'package:yuro/yuro_route/yuro_route.dart';

import 'src/overlay_theme.dart';

export 'src/toast/toast.dart';
export 'src/toast/theme.dart';

part 'src/overlay_container.dart';

extension YuroOverlayExt on YuroInterface {
  void showAnimatedWidget({
    required AnimationBuilder builder,
    required Widget child,
    String? tag,
    BuildContext? context,
    OverlayTheme? theme,
    VoidCallback? onDismiss,
  }) {
    tag ??= 'Null';
    final currentTheme = theme ?? OverlayTheme();
    if (currentTheme.onlyOne) _OverlayManager().dismissAll(tag);
    final containerKey = GlobalKey<_OverlayContainerState>();
    final overlayEntry = OverlayEntry(
      builder: (context) => OverlayContainer(builder, child, currentTheme, key: containerKey),
    );
    final future = _OverlayFuture(tag, overlayEntry, onDismiss, containerKey, currentTheme.animationDuration);
    future.timer = Timer(currentTheme.duration, future.dismiss);
    if (context == null) {
      Yuro.currentState.overlay?.insert(overlayEntry);
    } else {
      Overlay.of(context)?.insert(overlayEntry);
    }
    _OverlayManager().add(tag, future);
  }
}

class _OverlayManager {
  static late final _OverlayManager _instance = _OverlayManager._();

  _OverlayManager._();

  factory _OverlayManager() => _instance;

  final Map<String, Set<_OverlayFuture>> _map = {};

  void add(String tag, _OverlayFuture future) => _map.putIfAbsent(tag, () => {}).add(future);

  void remove(String tag, _OverlayFuture future) => _map[tag]?.remove(future);

  void dismissAll(String tag) => _map[tag]?.toList().forEach((element) => element.dismiss(false));
}

class _OverlayFuture {
  _OverlayFuture(this.tag, this.entry, this.onDismiss, this.containerKey, this.animationDuration);

  final String tag;
  final OverlayEntry entry;
  final VoidCallback? onDismiss;
  final GlobalKey<_OverlayContainerState> containerKey;
  final Duration animationDuration;

  Timer? timer;

  void dismiss([bool anim = true]) {
    timer?.cancel();
    onDismiss?.call();
    _OverlayManager().remove(tag, this);

    if (anim) {
      containerKey.currentState?.dismiss();
      Future.delayed(animationDuration, entry.remove);
    } else {
      entry.remove();
    }
  }
}
