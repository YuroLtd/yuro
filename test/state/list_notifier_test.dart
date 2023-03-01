import 'package:flutter_test/flutter_test.dart';
import 'package:yuro/state/src/listenable/notifier/list_notifier.dart';

void main() {
  test('list_notifier_test', () {
    final list = <int>[].obs;
    list.add(1);

    list.clear();
  });
}
