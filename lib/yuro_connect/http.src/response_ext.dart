import 'package:dio/dio.dart';

extension ResponseExt<T> on Response<T> {
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
