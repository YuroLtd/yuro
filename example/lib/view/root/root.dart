import 'package:example/export.dart';
import 'package:flutter/material.dart';

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text('Yuro Demo'), elevation: 0),
      body: ListView(children: [
        RouteItem(name: context.localizations.setting, route: AppRouteKeys.setting),
      ]));
}
