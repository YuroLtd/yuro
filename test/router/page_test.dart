import 'package:collection/collection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yuro/router/router.dart';

void main() {
  group('PathDecoder', () {
    PathDecoder decoder = PathDecoder.fromName('/test/:id/:name');

    test('parse', () {
      expect(decoder.keys, ['id', 'name']);
    });

    test('match', () {
      final path = [
        '/test/1/name/aa',
        '/aa/test/1/name/bb',
        '/test/1/name',
      ];
      final match = path.firstWhereOrNull((e) => decoder.regexp.hasMatch(e));
      expect(match, path[2]);
    });

    test('Inverse parse', () {
      const path = '/test/1/name';
      final match = decoder.regexp.firstMatch(path);
      final a = decoder.keys.mapIndexed((index, element) => MapEntry(element, match![index + 1]!));
      final params = Map.fromEntries(a);
      expect(params['id'], '1');
      expect(params['name'], 'name');
    });
  });
}
