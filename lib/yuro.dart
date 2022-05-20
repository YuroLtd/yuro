library yuro;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/single_child_widget.dart';

import 'yuro_analysis/yuro_analysis.dart';
import 'yuro_app/yuro_app.dart';
import 'yuro_core/yuro_core.dart';
import 'yuro_state/yuro_state.dart';
import 'yuro_route/yuro_route.dart';
import 'yuro_util/yuro_util.dart';
import 'yuro_widget/yuro_widget.dart';

export 'package:yuro/yuro_analysis/yuro_analysis.dart';
export 'package:yuro/yuro_app/yuro_app.dart';
export 'package:yuro/yuro_connect/yuro_connect.dart';
export 'package:yuro/yuro_core/yuro_core.dart';
export 'package:yuro/yuro_route/yuro_route.dart';
export 'package:yuro/yuro_state/yuro_state.dart';
export 'package:yuro/yuro_util/yuro_util.dart';
export 'package:yuro/yuro_widget/yuro_widget.dart';

export 'package:permission_handler/permission_handler.dart';
export 'package:equatable/equatable.dart';

/// 程序入口
void runYuroApp({
  Future<void> Function()? onInit,
  AppConfig config = const AppConfig(),
  List<SingleChildWidget> providers = const [],
  Widget Function(BuildContext context, Widget child)? builder,
  required YuroApp child,
}) =>
    runZonedGuarded(
      () async {
        WidgetsFlutterBinding.ensureInitialized();
        await Yuro.loadUserAgent();
        // 初始化SharedPreferences
        await Yuro.initSharedPreferences();
        // 初始化hive数据库
        await Yuro.initHive();
        await onInit?.call();
        await _loadConfig(config);
        // 绑定全局路由监听
        YuroWidgetsBindingObserver();
        FlutterError.onError = YuroCrashlytics.instance.recordFlutterError;
        // 启动app
        runApp(MultiProvider(
          providers: [...providers, Provider.value(value: config)],
          child: builder != null ? Builder(builder: (context) => builder(context, child)) : child,
        ));
      },
      (err, stack) => YuroCrashlytics.instance.recordError(err, stack),
    );

Future<void> _loadConfig(AppConfig config) async {
  if (config.errorWidgetBuilder != null) {
    ErrorWidget.builder = config.errorWidgetBuilder!;
  }
  if (config.logConfig != null) {
    Yuro.changeLogConfig(config.logConfig!);
  }
  if (config.toastTheme != null) {
    Yuro.changeToastTheme(config.toastTheme!);
  }
  if (config.loadingTheme != null) {
    Yuro.changeLoadingTheme(config.loadingTheme!);
  }
  if (config.designSize != null) {
    Screen.changeDesignSize(config.designSize!.width, config.designSize!.height);
  }
  // 状态栏颜色修改
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: config.statusBarColor));
}
