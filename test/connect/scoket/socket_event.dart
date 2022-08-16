import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:buffer/buffer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yuro/connect/socket.src/events.dart';
import 'package:yuro/util/util.dart';

void main() {
  test('build event', () {
    for (int i = 0; i < 5; i++) {
      var text = SocketEvent.text(false, '123');
      print(text.toJsonStr());

      var bytes = text.toBytes();
      // print(bytes);
      // print(bytes.base64());

      var event = SocketEvent.fromBytes(bytes);
      print(event.toJsonStr());
      print('');
    }
  });

  test('xor', () {
    for (int i = 0; i < 50; i++) {
      final mask = List.generate(4, (index) => Random().nextInt(255)).toList();
      print('mask => $mask');

      final o = [49, 50, 51];
      print('o=>$o');
      final r = o.mapIndexed((index, element) => element ^ mask[index % 4]).toList();
      print('r1 => $r');

      final r2 = r.mapIndexed((index, element) => element ^ mask[index % 4]).toList();
      print('r2 => $r2');

      print('-------------');
    }
  });

  test('split', () {
    for(int i = 0; i < 10; i++){
      final a = List.generate(4, (index) => Random().nextInt(255));
      print(a);
      print(a.map((e) => e.toRadixString(16)).join());
      final b = a.map((e) => e.toRadixString(2).padLeft(8,'0')).join();
      print(b);
      final c = int.parse(b, radix: 2);
      print(c);



      final maskingKey = [c >> 24, (c & 0x00FF0000) >> 16, (c & 0x0000FF00) >> 8, c & 0x000000FF];
      print(maskingKey);
      print(maskingKey.map((e) => e.toRadixString(16)).join());
      print('');
    }
  });
}
