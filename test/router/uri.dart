// ignore_for_file: avoid_print

import 'package:flutter_test/flutter_test.dart';

void main(){
  test('uri', () {
    var url = '/home//setting/locale?test=1,2,3&test2=45';
    var uri = Uri.parse(url);
    print(uri.path);
    print(uri.pathSegments);
    print(uri.queryParameters);
    print(uri.query);
    print(uri.queryParametersAll);

    print('\n');

    url = '/home/1';

    uri = Uri(path: url);
    print(uri);

    uri = Uri(path: url, queryParameters: {});
    print(uri);

    uri = Uri(path: url, queryParameters: {'test': '1,2,3', 'test2': '45'});
    print(uri);
  });
}