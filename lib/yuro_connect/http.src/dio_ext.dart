import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

extension DioExt on Dio {
  set baseUrl(String url) {
    options.baseUrl = url;
  }

  set connectTimeout(Duration timeout) {
    options.connectTimeout = timeout.inMilliseconds;
  }

  set receiveTimeout(Duration timeout) {
    options.receiveTimeout = timeout.inMilliseconds;
  }

  set sendTimeout(Duration timeout) {
    options.sendTimeout = timeout.inMilliseconds;
  }

  set contentType(String contentType) {
    options.contentType = contentType;
  }

  set responseType(ResponseType type) {
    options.responseType = type;
  }

  set headers(Map<String, dynamic> headers) {
    options.headers.addAll(headers);
  }

  set queryParameters(Map<String, dynamic> parameters) {
    options.queryParameters.addAll(parameters);
  }

  set extras(Map<String, dynamic> extras) {
    options.extra.addAll(extras);
  }

  set validateStatus(ValidateStatus validateStatus) {
    options.validateStatus = validateStatus;
  }

  set receiveDataWhenStatusError(bool receiveDataWhenStatusError) {
    options.receiveDataWhenStatusError = receiveDataWhenStatusError;
  }

  set followRedirects(bool followRedirects) {
    options.followRedirects = followRedirects;
  }

  set maxRedirects(int maxRedirects) {
    options.maxRedirects = maxRedirects;
  }

  set requestEncoder(RequestEncoder requestEncoder) {
    options.requestEncoder = requestEncoder;
  }

  set responseDecoder(ResponseDecoder responseDecoder) {
    options.responseDecoder = responseDecoder;
  }

  /// eg. 192.168.0.1:8888
  set openProxy(String? proxy) {
    if (proxy == null) return;
    (httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
      client.findProxy = (uri) => "PROXY $proxy";
    };
  }

  void addInterceptor(Interceptor interceptor) {
    interceptors.add(interceptor);
  }

  void addInterceptors(List<Interceptor> list) {
    interceptors.addAll(list);
  }

  void setCertificate(String pem) {
    (httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
      client.badCertificateCallback = (cert, host, port) => cert.pem == pem;
    };
  }

  void setCertificateFile(File file) {
    (httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
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
