import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:yuro/state/service.dart';

abstract class HttpService extends YuroService {
  // ignore: prefer_final_fields
  Dio _dio = Dio();

  Dio get dio => _dio;
}

mixin HttpServiceMixin on HttpService {
  set baseUrl(String url) {
    _dio.options.baseUrl = url;
  }

  set connectTimeout(Duration timeout) => _dio.options.connectTimeout = timeout;

  set receiveTimeout(Duration timeout) => _dio.options.receiveTimeout = timeout;

  set sendTimeout(Duration timeout) => _dio.options.sendTimeout = timeout;

  set contentType(String contentType) => _dio.options.contentType = contentType;

  set responseType(ResponseType type) => _dio.options.responseType = type;

  set headers(Map<String, dynamic> headers) => _dio.options.headers.addAll(headers);

  set queryParameters(Map<String, dynamic> parameters) => _dio.options.queryParameters.addAll(parameters);

  set extras(Map<String, dynamic> extras) => _dio.options.extra.addAll(extras);

  set validateStatus(ValidateStatus validateStatus) => _dio.options.validateStatus = validateStatus;

  set receiveDataWhenStatusError(bool receiveDataWhenStatusError) => _dio.options.receiveDataWhenStatusError = receiveDataWhenStatusError;

  set followRedirects(bool followRedirects) => _dio.options.followRedirects = followRedirects;

  set maxRedirects(int maxRedirects) => _dio.options.maxRedirects = maxRedirects;

  set requestEncoder(RequestEncoder requestEncoder) => _dio.options.requestEncoder = requestEncoder;

  set responseDecoder(ResponseDecoder responseDecoder) => _dio.options.responseDecoder = responseDecoder;

  void addInterceptor(Interceptor interceptor) => _dio.interceptors.add(interceptor);

  void addInterceptors(List<Interceptor> list) => _dio.interceptors.addAll(list);

  void setCertificate(String pem) {
    dio.httpClientAdapter = IOHttpClientAdapter(createHttpClient: () {
      final client = HttpClient(context: SecurityContext(withTrustedRoots: false));
      client.badCertificateCallback = (cert, host, port) => cert.pem == pem;
      return client;
    });
  }

  void setCertificateFile(File file) {
    dio.httpClientAdapter = IOHttpClientAdapter(createHttpClient: () {
      return HttpClient(context: SecurityContext()..setTrustedCertificates(file.path));
    });
  }

  /// eg. 192.168.0.1:8888
  set httpProxy(String? proxy) {
    dio.httpClientAdapter = IOHttpClientAdapter(createHttpClient: () {
      return HttpClient()..findProxy = (url) => proxy == null ? 'DIRECT' : "PROXY $proxy";
    });
  }

  void openLog({
    bool request = false,
    bool requestHeader = false,
    bool requestBody = true,
    bool responseHeader = false,
    bool responseBody = true,
  }) {
    addInterceptor(LogInterceptor(
        request: request,
        requestHeader: requestHeader,
        requestBody: requestBody,
        responseHeader: responseHeader,
        responseBody: responseBody));
  }
}
