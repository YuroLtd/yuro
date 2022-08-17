import 'package:example/export.dart';
import 'package:flutter/material.dart';

class WidgetsDemo extends StatelessWidget {
  const WidgetsDemo({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: appBar(title: context.localizations.widgets),
      body: ListView(children: [
        RouteItem(name: context.localizations.expandableText, route: AppRouteKeys.widgets_expandable_text),
      ]));
}
