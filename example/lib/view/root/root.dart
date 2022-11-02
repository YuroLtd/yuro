import 'package:example/export.dart';
import 'package:flutter/material.dart';

class RootController extends YuroController {
  @override
  void onReady() {
    super.onReady();
    // CrashHandler.instance.report();
  }
}

class Root extends YuroView<RootController> {
  const Root({super.key});

  @override
  RootController createController() => RootController();

  @override
  Widget builder(BuildContext context, RootController controller) => Scaffold(
      appBar: appBar(title: S.of(context).appName),
      body: ListView(children: [
        RouteItem(name: S.of(context).exception, route: AppRouteKeys.exception),
        RouteItem(name: S.of(context).widgets, route: AppRouteKeys.widgets),
        RouteItem(name: S.of(context).setting, route: AppRouteKeys.setting),
      ]));
}
