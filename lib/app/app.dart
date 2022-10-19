import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:yuro/core/core.dart';
import 'package:yuro/storage/storage.dart';
import 'package:yuro/util/src/convert.dart';

import 'src/yuro_app.dart';

export 'src/yuro_app.dart';

typedef YuroAppBuilder = YuroApp Function();

void runYuroApp({
  required YuroAppBuilder builder,
  VoidCallback? onInit,
  bool? enableLog,
  LogLevel? logLevel,
  FlutterExceptionHandler? onFlutterError,
  ErrorCallback? onPlatFormError,
}) async {
  WidgetsFlutterBinding.ensureInitialized();

  // 初始化SharedPreferences
  await Yuro.initSharedPreferences();
  // 初始化日志开关
  Yuro.enableLog = enableLog ?? kDebugMode;
  if (logLevel != null) Yuro.logLevel = logLevel;
  // 绑定错误处理
  FlutterError.onError = onFlutterError ?? FlutterError.presentError;
  PlatformDispatcher.instance.onError = onPlatFormError ??
      (error, stack) {
        FlutterError.presentError.call(FlutterErrorDetails(exception: error, stack: stack));
        return true;
      };
  // 初始化SharedPreferences
  await Yuro.initSharedPreferences();
  // 初始化hive数据库
  await Hive.initFlutter();

  // 调用自定义初始化方法
  onInit?.call();

  // 启动应用
  runApp(builder.call());
}
