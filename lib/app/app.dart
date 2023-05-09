import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yuro/core/core.dart';
import 'package:yuro/storage/storage.dart';

import 'src/yuro_app.dart';

export 'src/yuro_app.dart';

typedef YuroAppBuilder = YuroApp Function();

void runYuroApp({
  FutureVoidCallback? beforeRun,
  FlutterExceptionHandler? onFlutterError,
  ErrorCallback? onPlatformError,
  SystemUiOverlayStyle? systemUiOverlayStyle,
  required YuroAppBuilder builder,
}) async {
  WidgetsFlutterBinding.ensureInitialized();

  // 初始化SharedPreferences
  await Yuro.initSharedPreferences();

  // 调用自定义初始化方法
  await beforeRun?.call();

  // 绑定错误处理
  if (onFlutterError != null) FlutterError.onError = onFlutterError;
  if (onPlatformError != null) PlatformDispatcher.instance.onError = onPlatformError;

  // 状态栏配置
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle ?? const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  // 启动应用
  runApp(builder.call());
}
