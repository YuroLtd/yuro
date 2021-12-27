library yuro_app;

import 'package:flutter/material.dart';
import 'package:yuro/yuro_analysis/logger/src/config.dart';
import 'package:yuro/yuro_widget/src/overlay/loading/loading.dart';
import 'package:yuro/yuro_widget/src/overlay/toast/toast.dart';

export 'src/yuro_app.dart';
export 'src/yuro_app_ext.dart';

const String KEY_LOCALE = 'key_locale';
const String KEY_THEME_MODE = 'key_theme_mode';

class AppConfig {
  final String? appId;
  final String? appSecret;
  final Size? designSize;
  final Color? statusBarColor;
  final LogConfig? logConfig;
  final ToastTheme? toastTheme;
  final LoadingTheme? loadingTheme;
  final ErrorWidgetBuilder? errorWidgetBuilder;
  final Map<String, dynamic> extra;

  const AppConfig({
    this.appId,
    this.appSecret,
    this.designSize,
    this.statusBarColor,
    this.logConfig,
    this.toastTheme,
    this.loadingTheme,
    this.errorWidgetBuilder,
    this.extra = const {},
  });
}
