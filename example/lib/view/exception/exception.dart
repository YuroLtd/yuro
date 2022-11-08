import 'package:example/export.dart';
import 'package:flutter/material.dart';

class ExceptionController extends YuroController {
  final str =
      "{\"dictCode\":6,\"dictSort\":1,\"dictLabel\":null,\"dictValue\":\"0\",\"dictType\":\"sys_normal_disable\"}";

  void syncException() {
    final dict = Dict.fromJson(str.decodeJson());
    Yuro.tag('exception').i(dict.toJson());
  }

  void asyncException() {
    Future.delayed(20.millisecond, () {
      final dict = Dict.fromJson(str.decodeJson());
      Yuro.tag('exception').i(dict.toJson());
    });
  }

  void report() {
    CrashHandler.get().report();
  }
}

class ExceptionPage extends YuroView<ExceptionController> {
  const ExceptionPage({super.key});

  @override
  ExceptionController createController() => ExceptionController();

  @override
  Widget builder(BuildContext context, ExceptionController controller) => Scaffold(
      appBar: appBar(title: S.of(context).exception),
      body: Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
          child: Column(children: [
            ElevatedButton(onPressed: controller.syncException, child: Text(S.of(context).exception_sync)),
            ElevatedButton(onPressed: controller.asyncException, child: Text(S.of(context).exception_async)),
            ElevatedButton(onPressed: controller.report, child: Text(S.of(context).exception_upload)),
          ])));
}
