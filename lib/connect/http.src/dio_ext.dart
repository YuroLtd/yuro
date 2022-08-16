import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:yuro/util/src/file_system.dart';
import 'package:yuro/util/src/string.dart';

extension DioExt on Dio {
  /// 断点续传下载
  void rangDownload(
    String url,
    String savePath, {
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    VoidCallback? onStart,
    required ProgressCallback onProgress,
    void Function(dynamic err)? onError,
    VoidCallback? onDone,
  }) async {
    onStart?.call();
    int start = 0;
    final file = File(savePath);
    if (file.existsSync()) {
      start = file.lengthSync();
    } else {
      file.createIfNotExists(true);
    }
    final raf = await file.open(mode: FileMode.append);
    try {
      int received = start;
      // 通过head请求获取文件的长度
      final headResponse = await head(url, queryParameters: queryParameters);
      final total = headResponse.headers.value(HttpHeaders.contentLengthHeader)?.toInt();
      if (total == null) throw Exception('无法获取文件长度');
      if (received == total) {
        await raf.close();
        onDone?.call();
        return;
      }
      // 获取下载流
      final response = await get<ResponseBody>(url,
          queryParameters: queryParameters,
          options: Options(
            responseType: ResponseType.stream,
            followRedirects: false,
            headers: {'range': 'bytes=$start-'},
          ));
      // 将流写入文件
      final subscription = response.data!.stream.listen(
        (data) {
          raf.writeFromSync(data);
          received += data.length;
          onProgress.call(received, total);
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
      cancelToken?.whenCancel.then((_) async {
        await subscription.cancel();
        await raf.close();
      });
    } on Exception catch (err) {
      await raf.close();
      onError?.call(err);
    }
  }
}
