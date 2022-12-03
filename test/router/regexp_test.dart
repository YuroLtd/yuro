// ignore_for_file: avoid_print

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('RegExp', () {
    final regexp = RegExp(r'(.)?/:\w+');
    expect(regexp.hasMatch('/home/setting'), false);
    expect(regexp.hasMatch('/home/:id'), true);
    expect(regexp.hasMatch('/home/:'), false);
    expect(regexp.hasMatch(':id'), false);
    expect(regexp.hasMatch('/:id'), true);
    expect(regexp.hasMatch('/home/:id/'), true);
    expect(regexp.hasMatch('/home/:id/:name'), true);
    expect(regexp.hasMatch('/home/:id/name'), true);
  });

  List<String?> getKeys(RegExp regexp, String input) => regexp.allMatches(input).map((e) => e[2]).toList();

  test('RegExp.keys', () {
    final regexp = RegExp(r'(\.)?:(\w+)?');
    var keys = getKeys(regexp, '/home/:id/:name');
    expect(keys, ['id', 'name']);

    keys = getKeys(regexp, '/home/:id/:name/');
    expect(keys, ['id', 'name']);

    keys = getKeys(regexp, '/home/:id/:name/:');
    expect(keys, ['id', 'name', null]);

    keys = getKeys(regexp, '/home/:id/:name/:1');
    print(keys);
  });
}
