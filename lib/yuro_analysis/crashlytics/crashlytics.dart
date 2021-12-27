import 'dart:isolate';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:yuro/yuro_app/yuro_app.dart';
import 'package:yuro/yuro_core/yuro_core.dart';
import 'package:yuro/yuro_util/yuro_util.dart';

import '../database/analysis.dart';

class YuroCrashlytics {
  static YuroCrashlytics? _instance;

  static YuroCrashlytics get instance => _instance ??= YuroCrashlytics._();

  YuroCrashlytics._() {
    Isolate.current.addErrorListener(RawReceivePort((pair) {
      final errorAndStackTrace = pair as List<dynamic>;
      recordError(errorAndStackTrace.first, errorAndStackTrace.last);
    }).sendPort);
  }

  // 记录框架捕获的非致命错误
  void recordFlutterError(FlutterErrorDetails details) {
    FlutterError.presentError(details);
    recordError(
      details.exceptionAsString(),
      details.stack,
      reason: details.context,
      information: details.informationCollector?.call() ?? [],
      printDetails: false,
    );
  }

  void recordError(
    dynamic exception,
    StackTrace? stackTrace, {
    dynamic reason,
    Iterable<DiagnosticsNode> information = const [],
    bool? printDetails,
    bool fatal = false,
  }) async {
    // 屏蔽掉DioError的一般连接错误
    if (exception is DioError) {
      if (exception.type != DioErrorType.other) return;
      stackTrace = exception.stackTrace;
      exception = exception.message;
    }
    final _information = information.isEmpty ? '' : (StringBuffer()..writeAll(information, '\n')).toString();
    if (printDetails ?? kDebugMode) {
      print('--------------------------------------CRASHLYTICS--------------------------------------');
      if (reason != null) {
        print('The following exception was thrown $reason:');
      }
      print(exception);
      if (_information.isNotEmpty) {
        print('\n$_information');
      }
      if (exception is! DioError && stackTrace != null) {
        print('\n$stackTrace');
      }
      print('---------------------------------------------------------------------------------------');
    }
    final crashlytics = Crashlytics(
        message: exception.toString(),
        stackTrace: stackTrace.toString(),
        signature: '${Yuro.versionName}&&$exception&&$stackTrace'.toMd5(),
        appVersion: Yuro.versionName,
        createTime: DateTime.now());
    AnalysisDatabase.instance.putCrashlytics(crashlytics);
  }

  void upload() async {
    // 如果没有配置崩溃上传地址,则中断操作
    final appId = Yuro.appConfig.appId;
    if (appId.isNullOrBlank || Yuro.appConfig.crashlyticsDomain.isNullOrBlank) return;
    final noneUploadList = AnalysisDatabase.instance.notUploadCrashlytics();
    if (noneUploadList.isEmpty) return;
    final waitUpload = noneUploadList
        .map((e) => {
              'appId': appId,
              'message': e.message,
              'stackTrace': e.stackTrace,
              'signature': e.signature,
              'versionName': e.appVersion,
              'count': e.count,
              'updateTime': e.updateTime?.millisecondsSinceEpoch,
              'createTime': e.createTime.millisecondsSinceEpoch,
            })
        .toList();
    final response = await Dio().requestUri(
      Uri.parse(Yuro.appConfig.crashlyticsDomain!),
      data: waitUpload,
      options: Options(method: 'POST'),
    );
    if (response.statusCode == 200 && response.data['code'] == 200) {
      final ids = noneUploadList.map((e) => e.id).toList();
      AnalysisDatabase.instance.batchDeleteCrashlytics(ids);
      Yuro.tag('Crashlytics').i('crashlytics was uploaded.');
    }
  }
}
