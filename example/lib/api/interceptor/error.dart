import 'dart:io';

import 'package:example/export.dart';


/// 错误拦截器
class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioErrorType.connectTimeout:
        err.error = '网络连接超时';
        break;
      case DioErrorType.sendTimeout:
        err.error ='网络连接超时';
        break;
      case DioErrorType.receiveTimeout:
        err.error = '网络响应超时';
        break;
      case DioErrorType.response:
        err.error = '服务器异常';
        break;
      case DioErrorType.cancel:
        err.error = '请求取消';
        break;
      case DioErrorType.other:
        if (err.error is SocketException || err.error is HttpException) {
          err.error = '网络连接异常';
        }
        break;
    }
    super.onError(err, handler);
  }
}
