import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:yuro/yuro.dart';
import 'package:flutter/material.dart';

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

  void addInterceptor(Interceptor interceptor) {
    interceptors.add(interceptor);
  }

  void addInterceptors(List<Interceptor> list) {
    interceptors.addAll(list);
  }

  void setCertificate(String pem) {
    (httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
      client.badCertificateCallback = (cert, host, port) => cert.pem == pem;
      return client;
    };
  }

  void setCertificateFile(File file) {
    (httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
      return HttpClient(context: SecurityContext()..setTrustedCertificates(file.path));
    };
  }

  /// eg. 192.168.0.1:8888
  void openProxy(String? proxy) {
    if (proxy.isNullOrBlank) return;
    (httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
      client.findProxy = (uri) => "PROXY $proxy";
      return client;
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

  /// 断点下载
  Future<CancelToken> rangDownload(
    String url,
    String savePath, {
    Map<String, dynamic>? queryParameters,
    required ProgressCallback? onProgress,
    VoidCallback? onDone,
    void Function(dynamic err)? onError,
  }) async {
    int start = 0;
    final file = File(savePath);
    if (file.existsSync()) {
      start = file.lengthSync();
    } else {
      file.createIfNotExists(recursive: true);
    }
    final cancelToken = CancelToken();
    try {
      final response = await get<ResponseBody>(
        url,
        queryParameters: queryParameters,
        options: Options(
          responseType: ResponseType.stream,
          followRedirects: false,
          headers: {'range': 'bytes=$start-'},
        ),
      );
      final raf = file.openSync(mode: FileMode.append);
      int received = start;
      var rangHeader = response.headers.value(HttpHeaders.contentRangeHeader) ??
          response.headers.value(HttpHeaders.contentLengthHeader);
      if (rangHeader == null) throw Exception('获取文件长度失败!');
      int total = int.tryParse(rangHeader.split('/').last) ?? 0;

      final stream = response.data!.stream;
      final subscription = stream.listen(
        (data) {
          raf.writeFromSync(data);
          received += data.length;
          onProgress?.call(received, total);
        },
        onDone: () async {
          await raf.close();
          onDone?.call();
        },
        onError: (err) async {
          await raf.close();
          onError?.call(err);
        },
        cancelOnError: true,
      );
      cancelToken.whenCancel.then((_) async {
        await subscription.cancel();
        await raf.close();
      });
    } on Exception catch (err) {
      onError?.call(err);
    }
    return cancelToken;
  }
}
