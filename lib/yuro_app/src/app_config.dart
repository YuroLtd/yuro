import 'package:flutter/material.dart';
import 'package:yuro/yuro_core/yuro_core.dart';
import 'package:yuro/yuro_widget/src/overlay/loading/loading.dart';
import 'package:yuro/yuro_widget/src/overlay/toast/toast.dart';

class AppConfig {
  final String? appId;
  final String? appSecret;
  final String? appChannel;

  /// 崩溃日志上传地址
  final String? crashlyticsDomain;

  //
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
    this.appChannel,
    this.crashlyticsDomain,
    //
    this.designSize,
    this.statusBarColor,
    this.logConfig,
    this.toastTheme,
    this.loadingTheme,
    this.errorWidgetBuilder,
    this.extra = const {},
  });
}
