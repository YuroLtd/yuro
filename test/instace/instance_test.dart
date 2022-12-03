import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yuro/core/core.dart';
import 'package:yuro/instance/instance.dart';

class Mock {
  static Future<String> test() async {
    await Future.delayed(Duration.zero);
    return 'test';
  }
}

abstract class MyController with YuroLifeCycleMixin {}

class DisposableController extends MyController {}

class Counter extends DisposableController {
  int init = 0;
  int disposed = 0;

  int count = 0;

  @override
  void onInit() {
    debugPrint('Counter onInit()');
    init++;
  }

  @override
  void onDispose() {
    debugPrint('Counter dispose()');
    disposed++;
  }

  void increment() {
    count++;
  }
}

abstract class Service {
  String post();
}

class Api implements Service {
  @override
  String post() {
    return 'test';
  }
}

void main() {
  test('Yuro.putAsync test', () async {
    await Yuro.putAsync<String>(() => Mock.test());
    expect('test', Yuro.find<String>());
    Yuro.resetInstance();
  });

  test('Yuro.put test', () {
    final instance = Yuro.put(Counter());
    expect(instance, Yuro.find<Counter>());
    Yuro.resetInstance();
  });

  test('Yuro.put with tag test', () {
    final instance = Yuro.put(Counter(), tag: 'one');
    final instance2 = Yuro.put(Counter(), tag: 'two');
    expect(instance == instance2, false);
    expect(Yuro.find<Counter>('one'), instance);
    expect(Yuro.find<Counter>('two'), instance2);
    expect(Yuro.find<Counter>('one') == Yuro.find<Counter>('two'), false);
    Yuro.resetInstance();
  });

  test('Yuro.lazyPut test', () {
    final counter = Counter();
    Yuro.lazyPut(() => counter);

    final instance = Yuro.find<Counter>();
    expect(instance, counter);

    Yuro.resetInstance();
  });

  test('Yuro.lazyPut with tag test', () {
    Yuro.lazyPut(() => Counter(), tag: 'one');
    Yuro.lazyPut(() => Counter(), tag: 'two');
    expect(Yuro.find<Counter>('one') == Yuro.find<Counter>('two'), false);
    Yuro.resetInstance();
  });

  test('Yuro.lazyPut with keepFactory test', () {
    Yuro.lazyPut(() => Counter(), tag: 'one', keepFactory: true);
    Yuro.find<Counter>('one').increment();
    expect(Yuro.find<Counter>('one').count, 1);
    Yuro.delete<Counter>(tag: 'one');
    expect(Yuro.find<Counter>('one').count, 0);
    //
    Yuro.lazyPut(() => Counter(), tag: 'two');
    Yuro.find<Counter>('two').increment();
    expect(Yuro.find<Counter>('two').count, 1);
    Yuro.delete<Counter>(tag: 'two');
    expect(() => Yuro.find<Counter>('two'), throwsA(const TypeMatcher<String>()));
    Yuro.resetInstance();
  });

  test('Counter onInit() and dispose()  is executed only once', () {
    Yuro
      ..put(Counter())
      ..put(Counter());

    final controller = Yuro.find<Counter>();
    expect(controller.init, 1);

    Yuro
      ..delete<Counter>()
      ..delete<Counter>();
    expect(controller.disposed, 1);

    Yuro.resetInstance();
  });

  test('Yuro.lazyPut with abstract class test', () {
    final api = Api();
    Yuro.lazyPut<Service>(() => api);
    expect(Yuro.find<Service>(), api);
    Yuro.resetInstance();
  });

  test('Yuro.create test', () {
    final instance = Yuro.create(() => Api());
    final instance2 = Yuro.create(() => Api());
    expect(instance == instance2, false);
    Yuro.resetInstance();
  });

  test('Yuro.reload test', () {
    Yuro.lazyPut(() => Counter());
    final instance = Yuro.find<Counter>();
    instance.increment();
    expect(instance.count, 1);
    expect(Yuro.find<Counter>().count, 1);

    Yuro.reload<Counter>();
    expect(Yuro.find<Counter>().count, 0);

    Yuro.resetInstance();
  });
}
