library yuro_app;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

export 'src/crash/yuro_crash.dart';
export 'src/tracker/yuro_tracker.dart';
export 'src/translation/translation.dart';

export 'src/yuro_app_controller.dart';
export 'src/yuro_material_app.dart';

/// 程序入口
///
/// @param onInit 需要在程序运行前执行的操作写在此方法中
///
/// @param onReady 程序运行起来后需要执行的操作写在此方法中
void runYuroApp(Widget app) async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(app);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
}
