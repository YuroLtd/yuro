import 'package:flutter/material.dart';
import 'package:example/export.dart';

class HomeProduct extends StatelessWidget {
  const HomeProduct({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text('HomeProduct')),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text('params: ${Yuro.params().toJsonStr()}\n\nqueryParams: ${Yuro.queryParams().toJsonStr()}'),
        TextButton(
            onPressed: () async {
              final a = await Yuro.pushNamed(
                   AppRouteKeys.home_product_component.params(Yuro.params()..put('cid', '2')));
              print(a);
            },
            child: const Text('to Component'))
      ]));
}

class HomeProductComponent extends StatelessWidget {
  const HomeProductComponent({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text('HomeProductComponent')),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text('params: ${Yuro.params().toJsonStr()}\n\nqueryParams: ${Yuro.queryParams().toJsonStr()}'),
        TextButton(
            onPressed: () {
              Yuro.pop('popResult');
            },
            child: const Text('to Product'))
      ]));
}
