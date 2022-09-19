import 'package:example/export.dart';
import 'package:flutter/material.dart';

class RouteItem extends StatelessWidget {
  final String name;
  final String route;
  final Widget? trailing;

  const RouteItem({super.key, required this.name, required this.route, this.trailing});

  void _onTap() => Yuro.pushNamed(route);

  @override
  Widget build(BuildContext context) => Column(mainAxisSize: MainAxisSize.min, children: [
        ListTile(
          title: Text(name, style: const TextStyle(fontSize: 12)),
          trailing: Row(mainAxisSize: MainAxisSize.min, children: [
            Offstage(offstage: trailing.isNull, child: trailing),
            const Icon(Icons.arrow_right),
          ]),
          onTap: _onTap,
        ),
        const Divider(height: 1)
      ]);
}
