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
          error: 'RESPONSE_EMPTY'));
    } else {
      if (response.data['code'] != 200) {
        handler.reject(
            DioError(
                requestOptions: response.requestOptions,
                response: response,
                type: DioErrorType.other,
                error: response.data['key']),
            true);
      } else {
        handler.next(response.copyWith(data: response.data['data']));
      }
    }
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioErrorType.connectTimeout:
        err.error = 'CONNECT_TIMEOUT';
        break;
      case DioErrorType.sendTimeout:
        err.error = 'SEND_TIMEOUT';
        break;
      case DioErrorType.receiveTimeout:
        err.error = 'RECEIVE_TIMEOUT';
        break;
      case DioErrorType.response:
        err.error = 'SERVER_ERROR';
        break;
      case DioErrorType.cancel:
        err.error = 'REQUEST_CANCEL';
        break;
      default:
        break;
    }
    handler.next(err);
  }
}

extension _ResponseExt<T> on Response<T> {
  Response<T> copyWith({
    T? data,
    Headers? headers,
    RequestOptions? requestOptions,
    bool? isRedirect,
    int? statusCode,
    String? statusMessage,
    List<RedirectRecord>? redirects,
    Map<String, dynamic>? extra,
  }) =>
      Response<T>(
        data: data ?? this.data,
        headers: headers ?? this.headers,
        requestOptions: requestOptions ?? this.requestOptions,
        isRedirect: isRedirect ?? this.isRedirect,
        statusCode: statusCode ?? this.statusCode,
        statusMessage: statusMessage ?? this.statusMessage,
        redirects: redirects ?? this.redirects,
        extra: extra ?? this.extra,
      );
}
