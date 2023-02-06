import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yuro/yuro.dart';

void main() {
  test('every', () async {
    final worker = Worker<int>.every((value) => debugPrint('[every] $value'));
    final timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      debugPrint('[tick]-> ${timer.tick}');
      worker.notifier(timer.tick);
    });
    await Future.delayed(const Duration(seconds: 5)).then((value) {
      timer.cancel();
      worker.dispose();
    });
  });

  test('once', () async {
    final a = 0.obs;
    final worker = Worker.once((value) => debugPrint('[once] $value'))..setNotifier(a);
    final timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      debugPrint('[tick]-> ${timer.tick}');
      a.value = timer.tick;
    });
    await Future.delayed(const Duration(seconds: 5)).then((value) {
      timer.cancel();
      worker.dispose();
    });
  });

  test('interval', () async {
    final a = 0.obs;
    final timer = Timer.periodic(const Duration(milliseconds: 150), (_) {
      debugPrint('[tick]-> ${_.tick}');
      a.value = _.tick;
    });
    final worker = Worker.interval((value) => debugPrint('[interval] $value'))..setNotifier(a);
    await Future.delayed(const Duration(seconds: 10)).then((value) {
      timer.cancel();
      worker.dispose();
    });
  });

  test('debounce', () async {
    final a = 0.obs;
    final timer = Timer.periodic(const Duration(milliseconds: 150), (_) {
      debugPrint('[tick]-> ${_.tick}');
      a.value = _.tick;
    });
    final worker = Worker.debounce((value) => debugPrint('[debounce] $value'))..setNotifier(a);
    await Future.delayed(const Duration(seconds: 10)).then((value) {
      timer.cancel();
      worker.dispose();
    });
  });
}
