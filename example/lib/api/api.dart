import 'package:example/export.dart';
import 'package:flutter/foundation.dart';

import 'interceptor/error.dart';
import 'interceptor/request.dart';
import 'interceptor/response.dart';

import 'src/system.dart';

class Api extends HttpService with HttpServiceMixin {
  static Api get() {
    if (!Yuro.isRegistered<Api>()) {
      return Yuro.put(Api._());
    }
    return Yuro.find<Api>();
  }

  Api._();

  static SystemApi get system => get()._sys;

  Environment get _environment => Yuro.find<Environment>();

  @override
  void onInit() {
    super.onInit();
    baseUrl = _environment.baseUrl;
    httpProxy = kDebugMode ? '192.168.0.132:8888' : null;
    openLog();
    addInterceptors([RequestInterceptor(), ResponseInterceptor(dio), ErrorInterceptor()]);
  }

  late final SystemApi _sys = SystemApiImpl(dio);
}
