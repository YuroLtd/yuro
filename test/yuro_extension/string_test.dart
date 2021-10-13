import 'package:flutter_test/flutter_test.dart';
import 'package:yuro/yuro_extension/yuro_extension.dart';

void main(){
  test('String?', (){
    String? str;

    print(str.isNullOrEmpty());
    print(str.isNullOrBlank());

    str = '';
    print(str.isNullOrEmpty());
    print(str.isNullOrBlank());

    str = ' ';
    print(str.isNullOrEmpty());
    print(str.isNullOrBlank());
  });
}