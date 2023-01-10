import 'package:yuro/core/core.dart';
import 'package:yuro/router/router.dart';

import 'listenable/listen_notifier.dart';

abstract class BaseController extends ListenNotifier with YuroLifeCycleMixin {}

abstract class YuroController extends BaseController {
  RouteDecoder? _decoder;

  @override
  void onInit() {
    _decoder = Yuro.routeDelegate.currentConfiguration;
    super.onInit();
  }

  /// 获取顶层页面的单个路径参数
  String? pathParam(String key) => pathParams()[key];

  /// 获取顶层页面的路径参数表
  Map<String, String> pathParams() => _decoder?.pathParams ?? {};

  /// 获取顶层页面的单个路由参数
  String? queryParam(String key) => queryParams()[key];

  /// 获取顶层页面的路由参数表
  Map<String, String> queryParams() => _decoder?.queryParams ?? {};

  /// 获取顶层页面传参
  T? arguments<T>() => _decoder?.arguments<T>();
}
