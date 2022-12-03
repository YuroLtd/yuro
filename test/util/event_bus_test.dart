import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yuro/yuro.dart';

void main() {
  test('every', () async {
    final a = 0.obs;
    final worker = Worker.every(a, (value) {
      debugPrint('[every] $value');
    });
    Timer.periodic(const Duration(milliseconds: 500), (timer) {
      debugPrint('[tick]-> ${timer.tick}');
      a.value = timer.tick;
    });
    await Future.delayed(const Duration(seconds: 5)).then((value) => worker.dispose());
  });

  test('once', () async {
    final a = 0.obs;
    final worker = Worker.once(a, (value) {
      debugPrint('[once] $value');
    });
    Timer.periodic(const Duration(milliseconds: 500), (timer) {
      debugPrint('[tick]-> ${timer.tick}');
      a.value = timer.tick;
    });
    await Future.delayed(const Duration(seconds: 5)).then((value) => worker.dispose());
  });

  test('interval', () async {
    final a = 0.obs;
    final timer = Timer.periodic(const Duration(milliseconds: 150), (_) {
      debugPrint('[tick]-> ${_.tick}');
      a.value = _.tick;
    });
    final worker = Worker.interval(
      a,
      (value) => debugPrint('[interval] $value'),
      onDone: () => timer.cancel(),
    );
    await Future.delayed(const Duration(seconds: 10)).then((value) => worker.dispose());
  });

  test('debounce', () async {
    final a = 0.obs;
    final timer = Timer.periodic(const Duration(milliseconds: 150), (_) {
      debugPrint('[tick]-> ${_.tick}');
      a.value = _.tick;
    });
    final worker = Worker.debounce(
      a,
      (value) => debugPrint('[debounce] $value'),
      onDone: () => timer.cancel(),
    );

    await Future.delayed(const Duration(seconds: 10)).then((value) => worker.dispose());
  });
}
