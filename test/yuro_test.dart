import 'dart:collection';

import 'package:flutter_test/flutter_test.dart';
import 'package:yuro/yuro_cache/src/lru_cache/lru_map.dart';


void main() {
  test('description', (){
    var map = LinkedHashMap<String,int>();
    map['a'] = 1;
    map['b'] = 2;
    map['c'] = 3;

    print(map.entries.toString());
    map['b'] = 4;
    print(map.entries.toString());

  });


  test("YuroCache",()async{
    var map = LruLinkedHashMap<String,int>();
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
