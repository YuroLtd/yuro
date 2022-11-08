import 'package:example/export.dart';
import 'package:flutter/material.dart';

class WidgetsPage extends StatelessWidget {
  const WidgetsPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: appBar(title: S.of(context).widgets),
      body: ListView(children: [
        RouteItem(name: S.of(context).expandableText, route: AppRouteKeys.widgets_expandable_text),
      ]));
}
