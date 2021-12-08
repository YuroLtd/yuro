library yuro;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/single_child_widget.dart';

import 'yuro_app/yuro_app.dart';
import 'yuro_cache/yuro_cache.dart';
import 'yuro_core/yuro_core.dart';
import 'yuro_intl/yuro_intl.dart';
import 'yuro_state/yuro_state.dart';
import 'yuro_route/yuro_route.dart';
import 'yuro_overlay/yuro_overlay.dart';
import 'yuro_screen/yuro_screen.dart';
import 'yuro_plus/yuro_plus.dart';

export 'package:yuro/yuro_app/yuro_app.dart';
export 'package:yuro/yuro_cache/yuro_cache.dart';
export 'package:yuro/yuro_connect/yuro_connect.dart';
export 'package:yuro/yuro_core/yuro_core.dart';

// export 'package:yuro/yuro_crash/yuro_crash.dart';
export 'package:yuro/yuro_extension/yuro_extension.dart';
export 'package:yuro/yuro_intl/yuro_intl.dart';
export 'package:yuro/yuro_plus/yuro_plus.dart';
export 'package:yuro/yuro_route/yuro_route.dart';
export 'package:yuro/yuro_screen/yuro_screen.dart';
export 'package:yuro/yuro_state/yuro_state.dart';
export 'package:yuro/yuro_overlay/yuro_overlay.dart';

// export 'package:yuro/yuro_tracker/yuro_tracker.dart';
export 'package:yuro/yuro_widget/yuro_widget.dart';

export 'package:permission_handler/permission_handler.dart';

/// 程序入口
void runYuroApp({
  required YuroApp child,
  Size designSize = const Size(360, 640),
  List<SingleChildWidget> providers = const [],
  Widget Function(BuildContext context, Widget child)? builder,
  Color statusBarColor = Colors.transparent,
  LogConfig? logConfig,
  ToastTheme? toastTheme,
  LoadingTheme? loadingTheme,
}) async {
  WidgetsFlutterBinding.ensureInitialized();
  // 绑定全局路由监听
  YuroWidgetsBindingObserver();

  // 初始化日志配置
  if (logConfig != null) Yuro.logConfig = logConfig;

  // 初始化Toast配置
  if (toastTheme != null) Yuro.toastTheme = toastTheme;

  // 初始化Loading配置
  if (loadingTheme != null) Yuro.loadingTheme = loadingTheme;

  // 初始化SharedPreferences
  await Yuro.initSharedPreferences();

  // 加载应用信息
  await Yuro.loadAppInfo();

  //加载ThemeMode
  var themeModeIndex = Yuro.sp.getInt(KEY_THEME_MODE);
  if (themeModeIndex != null) {
    Yuro.themeMode = ThemeMode.values[themeModeIndex];
  }

  //加载Locale
  var localeCache = Yuro.sp.getString(KEY_LOCALE);
  if (localeCache != null) {
    var config = localeCache.split('_');
    var locale = Locale(config[0], config.length == 2 ? config[1] : null);
    Yuro.locale = locale;
  }

  // 注入UI设计图尺寸
  Yuro.uiSize(designSize.width, designSize.height);

  // 启动app
  runApp(MultiProvider(
    providers: providers,
    child: builder != null ? Builder(builder: (context) => builder(context, child)) : child,
  ));

  // 开启沉浸式状态栏
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: statusBarColor));
}
