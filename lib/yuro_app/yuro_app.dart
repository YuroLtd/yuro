library yuro_app;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:yuro/yuro_core/yuro_core.dart';
import 'package:yuro/yuro_cache/yuro_cache.dart';
import 'package:yuro/yuro_extension/yuro_extension.dart';

export 'src/crash/yuro_crash.dart';
export 'src/tracker/yuro_tracker.dart';
export 'src/translation/translation.dart';

export 'src/yuro_app_controller.dart';
export 'src/yuro_material_app.dart';

/// 程序入口
void runYuroApp({
  required Widget app,
  OpenObjectBox? openStore,
  LogConfig? logConfig,
}) async {
  WidgetsFlutterBinding.ensureInitialized();
  // 初始化SharedPreferences
  await Yuro.initSharedPreferences();

  // 初始化ObjectBox数据库
  final appFlutterDir = await Yuro.applicationDocumentsDirectory;
  final directory = appFlutterDir.parent.path.join('objectbox');
  if (openStore != null) Yuro.objectboxStore = await openStore.call(directory);

  //初始化日志系统
  Yuro.initLogger(logConfig ?? LogConfig());
  // 启动app
  runApp(app);

  // 开启沉浸式状态栏
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
}
