library yuro_app;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:yuro/yuro_core/yuro_core.dart';
import 'package:yuro/yuro_cache/yuro_cache.dart';

export 'src/crash/yuro_crash.dart';
export 'src/tracker/yuro_tracker.dart';
export 'src/translation/translation.dart';

export 'src/yuro_app_controller.dart';
export 'src/yuro_material_app.dart';

/// 程序入口
void runYuroApp({OpenObjectBoxFunc? openObjectBox, required Widget app}) async {
  WidgetsFlutterBinding.ensureInitialized();
  // 初始化SharedPreferences
  await Yuro.initSharedPreferences();

  // 初始化ObjectBox数据库
  if (openObjectBox != null) {
    Yuro.objectboxStore = await openObjectBox.call();
  }

  runApp(app);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
}

typedef OpenObjectBoxFunc = Future<Store> Function();
