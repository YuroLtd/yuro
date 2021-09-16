import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

import 'interceptors/error.dart';

class DioClient {
  final Dio _dio = Dio();

  DioClient() {
    // 添加错误拦截器
    addInterceptor(ErrorInterceptor());
  }

  Dio get dio => _dio;

  set baseUrl(String url) {
    _dio.options.baseUrl = url;
  }

  set connectTimeout(Duration timeout) {
    _dio.options.connectTimeout = timeout.inMilliseconds;
  }

  set receiveTimeout(Duration timeout) {
    _dio.options.receiveTimeout = timeout.inMilliseconds;
  }

  set sendTimeout(Duration timeout) {
    _dio.options.sendTimeout = timeout.inMilliseconds;
  }

  set contentType(String contentType) {
    _dio.options.contentType = contentType;
  }

  set responseType(ResponseType type) {
    _dio.options.responseType = type;
  }

  set headers(Map<String, dynamic> headers) {
    _dio.options.headers.addAll(headers);
  }

  set queryParameters(Map<String, dynamic> parameters) {
    _dio.options.queryParameters.addAll(parameters);
  }

  set extras(Map<String, dynamic> extras) {
    _dio.options.extra.addAll(extras);
  }

  set validateStatus(ValidateStatus validateStatus) {
    _dio.options.validateStatus = validateStatus;
  }

  set receiveDataWhenStatusError(bool receiveDataWhenStatusError) {
    _dio.options.receiveDataWhenStatusError = receiveDataWhenStatusError;
  }

  set followRedirects(bool followRedirects) {
    _dio.options.followRedirects = followRedirects;
  }

  set maxRedirects(int maxRedirects) {
    _dio.options.maxRedirects = maxRedirects;
  }

  set requestEncoder(RequestEncoder requestEncoder) {
    _dio.options.requestEncoder = requestEncoder;
  }

  set responseDecoder(ResponseDecoder responseDecoder) {
    _dio.options.responseDecoder = responseDecoder;
  }

  /// eg. 192.168.0.1:8888
  set openProxy(String? proxy) {
    if (proxy == null) return;
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
      client.findProxy = (uri) => "PROXY $proxy";
    };
  }

  void addInterceptor(Interceptor interceptor) {
    _dio.interceptors.add(interceptor);
  }

  void addInterceptors(List<Interceptor> interceptors) {
    _dio.interceptors.addAll(interceptors);
  }

  void setCertificate(String pem) {
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
      client.badCertificateCallback = (cert, host, port) => cert.pem == pem;
    };
  }

  void setCertificateFile(File file) {
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
      return HttpClient(context: SecurityContext()..setTrustedCertificates(file.path));
    };
  }

  void openLog({
    bool request = false,
    bool requestHeader = false,
    bool requestBody = false,
    bool responseHeader = false,
    bool responseBody = false,
  }) {
    addInterceptor(LogInterceptor(
        request: request,
        requestHeader: requestHeader,
        requestBody: requestBody,
        responseHeader: responseHeader,
        responseBody: responseBody));
  }
}
