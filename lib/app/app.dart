import 'package:flutter/material.dart';
import 'package:yuro/core/core.dart';
import 'package:yuro/logger/logger.dart';
import 'package:yuro/storage/storage.dart';
import 'package:yuro/util/util.dart';

import 'src/yuro_app.dart';

export 'src/yuro_app.dart';

void runYuroApp({FutureVoidCallback? onInit,required YuroApp app}) async {
  WidgetsFlutterBinding.ensureInitialized();
  // 初始化SharedPreferences
  await Yuro.initSharedPreferences();

  // 初始化hive数据库
  // web不初始化,只有是桌面系统或手机系统才初始化
  if (!Yuro.isWeb) {
    // 初始化日志记录器
    Yuro.registerHiveAdapter(LogLevelAdapter());
    Yuro.registerHiveAdapter(LogRecordAdapter());
    await Yuro.initHive();
  }
  // 调用自定义初始化方法
  await onInit?.call();

  // 启动应用
  runApp(app);
}
