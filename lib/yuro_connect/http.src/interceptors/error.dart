import 'package:dio/dio.dart';

class ErrorInterceptor implements Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.data == null) {
      handler.reject(DioError(
        requestOptions: response.requestOptions,
        response: response,
        type: DioErrorType.other,
        error: DioErrorTypeExt.responseEmpty
      ));
    } else {}
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    // TODO: implement onError
  }
}


enum DioErrorTypeExt {
  responseEmpty
}