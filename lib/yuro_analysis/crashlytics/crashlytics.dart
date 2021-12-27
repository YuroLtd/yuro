import 'dart:isolate';

import 'package:dio/dio.dart';
import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:stack_trace/stack_trace.dart';

import '../drift/analysis_database.dart';

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
  }) {
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
    if (exception is DioError) {
      stackTrace = exception.stackTrace;
      exception = exception.message;
    }
    String? location;
    if (stackTrace != null) {
      final trace = Trace.parseVM(stackTrace.toString()).terse;
      if (trace.frames.isNotEmpty) {
        final frame = trace.frames.first;
        location = '${frame.member} (${frame.location})';
      }
    }
    final companion = CrashTableCompanion.insert(
      message: exception.toString(),
      stackTrace: stackTrace.toString(),
      location: location == null ? const Value.absent() : Value(location),
      createTime: DateTime.now(),
    );
    AnalysisDatabase.instance.crashDao.add(companion);
  }

  void upload(){

  }
}
