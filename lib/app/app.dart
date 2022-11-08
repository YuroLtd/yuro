import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yuro/core/core.dart';
import 'package:yuro/storage/storage.dart';
import 'package:yuro/util/util.dart';

import 'src/yuro_app.dart';

export 'src/yuro_app.dart';

typedef YuroAppBuilder = YuroApp Function();

void runYuroApp({
  required YuroAppBuilder builder,
  VoidCallback? onInit,
  Size? uiSize,
  bool? enableLog,
  LogLevel? logLevel,
  FlutterExceptionHandler? onFlutterError,
  ErrorCallback? onPlatFormError,
  SystemUiOverlayStyle? systemUiOverlayStyle,
}) async {
  WidgetsFlutterBinding.ensureInitialized();

  // 初始化SharedPreferences
  await Yuro.initSharedPreferences();

  // 调用自定义初始化方法
  onInit?.call();

  Yuro.changeUiSize(uiSize ?? const Size(360, 640));

  // 初始化日志开关
  if (enableLog != null) Yuro.enableLog = enableLog;
  if (logLevel != null) Yuro.logLevel = logLevel;

  // 绑定错误处理
  if (onFlutterError != null) FlutterError.onError = onFlutterError;
  if (onPlatFormError != null) PlatformDispatcher.instance.onError = onPlatFormError;

  // 状态栏配置
  if (systemUiOverlayStyle != null) SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);

  // 启动应用
  runApp(builder.call());
}
