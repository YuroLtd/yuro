import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yuro/router/router.dart';

void main() {
  group('route tree', () {
    var routeTree = RouteTree();
    final pages = [
      YuroPage(name: '/', builder: () => Container(), children: [
        YuroPage(name: '/profile', builder: () => Container()),
        YuroPage(name: '/setting', builder: () => Container(), children: [
          YuroPage(name: '/theme_mode', builder: () => Container()),
          YuroPage(name: '/locale', builder: () => Container()),
        ]),
      ])
    ];

    setUp(() => routeTree = RouteTree()..addPages(pages));

    test('addRoutes', () {
      expect(routeTree.routes.length, 5);
    });

    test('addRoute', () {
      routeTree.addPage(YuroPage(name: '/test', builder: () => Container()));
      expect(routeTree.routes.length, 6);
    });

    test('matchRoute', () {
      var path = '/setting/theme_mode';
      var match = routeTree.matchRoute(path, PageSettings.fromUrl(path));
      expect(match, isNotNull);
      expect(match.pathParams, isEmpty);
      expect(match.queryParams, isEmpty);

      routeTree.addPage(YuroPage(name: '/test/:id', builder: () => Container()));
      path = '/test/1?test=aaa';
      match = routeTree.matchRoute(path, PageSettings.fromUrl(path));
      expect(match, isNotNull);

      expect(match.pathParams, isNotEmpty);
      expect(match.pathParams['id'], '1');
      expect(match.queryParams, isNotEmpty);
      expect(match.queryParams['test'], 'aaa');
    });
  });
}
