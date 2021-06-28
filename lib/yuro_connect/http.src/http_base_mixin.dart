import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

import 'http_base.dart';

mixin HttpBaseMixin on HttpBase {
  set baseUrl(String url) {
    dio.options.baseUrl = url;
  }

  set connectTimeout(int timeout) {
    dio.options.connectTimeout = timeout;
  }

  set receiveTimeout(int timeout) {
    dio.options.receiveTimeout = timeout;
  }

  set sendTimeout(int timeout) {
    dio.options.sendTimeout = timeout;
  }

  set contentType(String contentType) {
    dio.options.contentType = contentType;
  }

  set responseType(ResponseType type) {
    dio.options.responseType = type;
  }

  set headers(Map<String, dynamic> headers) {
    dio.options.headers.addAll(headers);
  }

  set queryParameters(Map<String, dynamic> parameters) {
    dio.options.queryParameters.addAll(parameters);
  }

  set extras(Map<String, dynamic> extras) {
    dio.options.extra.addAll(extras);
  }

  set validateStatus(ValidateStatus validateStatus) {
    dio.options.validateStatus = validateStatus;
  }

  set receiveDataWhenStatusError(bool receiveDataWhenStatusError) {
    dio.options.receiveDataWhenStatusError = receiveDataWhenStatusError;
  }

  set followRedirects(bool followRedirects) {
    dio.options.followRedirects = followRedirects;
  }

  set maxRedirects(int maxRedirects) {
    dio.options.maxRedirects = maxRedirects;
  }

  set requestEncoder(RequestEncoder requestEncoder) {
    dio.options.requestEncoder = requestEncoder;
  }

  set responseDecoder(ResponseDecoder responseDecoder) {
    dio.options.responseDecoder = responseDecoder;
  }

  /// eg. 192.168.0.1:8888
  void openProxy(String proxy) {
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
      client.findProxy = (uri) => "PROXY $proxy";
    };
  }

  void setCertificate(String pem) {
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
      client.badCertificateCallback = (cert, host, port) => cert.pem == pem;
    };
  }

  void setCertificateFile(File file) {
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
      return HttpClient(context: SecurityContext()..setTrustedCertificates(file.path));
    };
  }

  void addInterceptor(Interceptor interceptor) {
    dio.interceptors.add(interceptor);
  }

  void addInterceptors(List<Interceptor> interceptors) {
    dio.interceptors.addAll(interceptors);
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
