import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yuro/route/go_router_config.dart';
import 'package:yuro/route/navigator_observer.dart';
import 'package:yuro/yuro.dart';

typedef YuroAppBuilder = YuroApp Function(BuildContext context);

void runYuroApp({
  List<SingleChildStatelessWidget> providers = const [],

  /// 设计图尺寸
  Size? uiSize,

  /// app启动前的初始化
  FutureVoidCallback? onInit,

  /// flutter异常捕获器
  FlutterExceptionHandler? onFlutterError,

  /// 平台异常捕获器
  ErrorCallback? onPlatformError,

  /// 系统UI样式
  SystemUiOverlayStyle? systemUiOverlayStyle,

  /// 路由配置
  GoRouterConfig? routerConfig,

  /// 系统路由配置
  required List<RouteBase> routes,

  /// 构建[YuroApp]
  required YuroAppBuilder builder,
}) async {
  WidgetsFlutterBinding.ensureInitialized();
  hierarchicalLoggingEnabled = true;

  // 初始化SharedPreferences
  Yuro.sp = await SharedPreferences.getInstance();
  // 初始化screen
  Yuro.screen = Screen(uiSize);

  // 绑定错误处理
  if (onFlutterError != null) FlutterError.onError = onFlutterError;
  if (onPlatformError != null) PlatformDispatcher.instance.onError = onPlatformError;

  // 配置SystemUiOverlayStyle
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle ?? const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  // 等待初始化工作
  await onInit?.call();

  // 加载路由配置
  final config = GoRouterConfig(observers: [YuroNavigatorObserver()]).merge(routerConfig);
  Yuro.router = GoRouter(
    routes: routes,
    errorPageBuilder: config.errorPageBuilder,
    errorBuilder: config.errorBuilder,
    redirect: config.redirect,
    refreshListenable: config.refreshListenable,
    redirectLimit: config.redirectLimit,
    routerNeglect: config.routerNeglect,
    initialLocation: config.initialLocation,
    initialExtra: config.initialExtra,
    observers: config.observers,
    debugLogDiagnostics: config.debugLogDiagnostics,
    navigatorKey: config.navigatorKey,
    restorationScopeId: config.restorationScopeId,
  );

  // 启动应用
  runApp(MultiProvider(providers: providers, builder: (context, _) => builder(context)));
}
