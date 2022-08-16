import 'dart:io';

import 'package:yuro/core/core.dart';

extension PlatformExt on YuroInterface {
  bool get isLinux => Platform.isLinux;

  bool get isMacOS => Platform.isMacOS;

  bool get isWindows => Platform.isWindows;

  bool get isAndroid => Platform.isAndroid;

  bool get isIOS => Platform.isIOS;

  bool get isFuchsia => Platform.isFuchsia;

  /// 是否是手机系统
  bool get isMobile => isAndroid || isIOS;

  /// 是否是桌面系统
  bool get isDesktop => isLinux || isMacOS || isWindows;

  /// 是否是Web端
  bool get isWeb {
    bool web;
    try {
      web = !(isMobile || isDesktop || isFuchsia);
    } catch (_) {
      web = true;
    }
    return web;
  }
}
