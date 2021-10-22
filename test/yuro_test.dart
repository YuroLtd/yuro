import 'dart:async';
import 'dart:collection';
import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:yuro/yuro_cache/src/lru_cache/lru_map.dart';

void main() {
  Future<bool> futureFunc() async{
    final completer = Completer<bool>();
    final random = Random().nextInt(10);
    await Future.delayed(Duration(seconds: 1));
    if (random.isOdd) {
      completer.complete(true);
    } else {
      completer.completeError('eerrr');
    }

    return completer.future;
  }

  test('description', () async {
   final a=  Stream.fromFutures([futureFunc()]);

      a.listen((event) { });
  });

  test("YuroCache", () async {
    var map = LruLinkedHashMap<String, int>();
    map['a'] = 1;
    map['b'] = 2;
    map['c'] = 3;
    print(map.entries.toString());
    print('');
    map['b'] = 4;
    print(map.entries.toString());
    print('');
    map['a'] = 5;
    print(map.entries.toString());
    print('');
    map['a'] = 6;
    print(map.entries.toString());
    print('');
    map['d'] = 7;
    print(map.entries.toString());
    print('');
    map['a'] = 8;
    print(map.entries.toString());

    map.remove('d');
    print(map.entries.toString());
  });
}
