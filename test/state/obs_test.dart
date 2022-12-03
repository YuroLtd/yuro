import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yuro/core/core.dart';
import 'package:yuro/instance/instance.dart';
import 'package:yuro/state/state.dart';

class Counter extends YuroController {
  final counter = 0.obs;
  final boolean = false.obs;
  final string = NStringNotifier();

  final list = <String>[].obs;

  void increment() {
    counter.value = ++counter.value;
    boolean.value = true;
    string.value = 'ok';
    list.value = ['1'];
  }
}

void main() {
  final controller = Yuro.put(Counter());

  testWidgets('Obs test', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Column(children: [
        Obs((child) => Text('counter: ${controller.counter.value}')),
        ObsValue<bool>(notifier: controller.boolean, builder: (value, child) => Text('boolean: $value')),
        ObsValue<String?>(notifier: controller.string, builder: (value, child) => Text('string: $value')),
        //
        Obs((child) => Text('list1: ${controller.list.value}')),
        ObsValue<List<String>>(notifier: controller.list, builder: (value, child) => Text('list2: $value')),
        //
        TextButton(
          onPressed: controller.increment,
          child: const Text("increment"),
        ),
      ]),
    ));

    expect(find.text('counter: 0'), findsOneWidget);
    expect(find.text('boolean: false'), findsOneWidget);
    expect(find.text('string: null'), findsOneWidget);
    expect(find.text('list1: []'), findsOneWidget);
    expect(find.text('list2: []'), findsOneWidget);

    controller.increment();

    await tester.pump();
    expect(find.text('counter: 1'), findsOneWidget);

    await tester.tap(find.text('increment'));
    await tester.pump();
    expect(find.text('counter: 2'), findsOneWidget);
    expect(find.text('boolean: true'), findsOneWidget);
    expect(find.text('string: ok'), findsOneWidget);
    expect(find.text('list1: [1]'), findsOneWidget);
    expect(find.text('list2: [1]'), findsOneWidget);
  });
}
