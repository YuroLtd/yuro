import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yuro/yuro_extension/yuro_extension.dart';

void main(){
  test('String?', (){
    String? str;

    debugPrint(str.isNullOrEmpty().toString());
    debugPrint(str.isNullOrBlank().toString());

    str = '';
    debugPrint(str.isNullOrEmpty().toString());
    debugPrint(str.isNullOrBlank().toString());

    str = ' ';
    debugPrint(str.isNullOrEmpty().toString());
    debugPrint(str.isNullOrBlank().toString());
  });
}