import 'dart:isolate';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:yuro/yuro_app/src/yuro_app_ext.dart';
import 'package:yuro/yuro_core/yuro_core.dart';
import 'package:yuro/yuro_util/yuro_util.dart';

import 'crash_info.dart';

class YuroCrashlytics {
  static YuroCrashlytics? _instance;

  static YuroCrashlytics get instance => _instance ??= YuroCrashlytics._();

  YuroCrashlytics._() {
    Yuro.registerHiveAdapter(CrashInfoAdapter());
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
    } else if (exception is PlatformException) {
      if (exception.stacktrace != null) {
        stackTrace = StackTrace.fromString(exception.stacktrace!);
      }
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

    final signature = '${Yuro.versionName}&&$exception&&$stackTrace'.toMd5();
    await Yuro.hive<CrashInfo>((box) async {
      final origin = box.values.where((element) => element.signature == signature).firstOrNull;
      if (origin != null) {
        origin
          ..count += 1
          ..updateTime = DateTime.now().format();
        await origin.save();
        Yuro.tag('Crashlytics').i('update ${origin.signature}, count: ${origin.count}');
      } else {
        await box.add(CrashInfo(
            message: exception.toString(),
            stackTrace: stackTrace.toString(),
            signature: signature,
            versionName: Yuro.versionName,
            createTime: DateTime.now().format()));
        Yuro.tag('Crashlytics').i('add $signature');
      }
    });
  }

  void upload() async {
    final appId = Yuro.appConfig.appId;
    final domain = Yuro.appConfig.crashlyticsDomain;
    if (appId.isNullOrBlank || domain.isNullOrBlank) return;
    await Yuro.hive<CrashInfo>((box) async {
      if (box.values.isNotEmpty) {
        final waitUpload = box.values.map((e) => e.toJson()..putIfAbsent('appId', () => appId)).toList();
        final response = await Dio().requestUri(
          Uri.parse(Yuro.appConfig.crashlyticsDomain!),
          options: Options(method: 'POST'),
          data: waitUpload,
        );
        if (response.statusCode == 200 && response.data['code'] == 200) {
          await box.clear();
          Yuro.tag('Crashlytics').i('upload success.');
        } else {
          Yuro.tag('Crashlytics').i('upload failed.');
        }
      }
    });
  }
}
