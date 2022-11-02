import 'package:example/export.dart';

/// 将access_token放入请求头
class RequestInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final xAuthToken = Yuro.sp.getString('x-auth-token');
    if (xAuthToken != null) {
      options.headers['x-auth-token'] = xAuthToken;
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    final xAuthToken = response.headers.value('x-auth-token');
    if (xAuthToken != null) {
      Yuro.sp.setString('x-auth-token', xAuthToken);
    }
    super.onResponse(response, handler);
  }
}
