import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:yuro/core/core.dart';
import 'package:yuro/logger/logger.dart';
import 'package:yuro/router/router.dart';

/// 路由解析器
class YuroRouteParser extends RouteInformationParser<RouteDecoder> {
  final String initialRoute;

  late final _logger = Yuro.tag('YuroRouteParser');

  YuroRouteParser({required this.initialRoute}) {
    _logger.v('created!');
  }

  @override
  Future<RouteDecoder> parseRouteInformation(RouteInformation routeInformation) {
    var location = routeInformation.location ?? initialRoute;
    if (location == '/') {
      if (!Yuro.routeTree.routes.any((element) => element.name == '/')) {
        location = initialRoute;
      }
    }
    _logger.v('parseRouteInformation -> $location');
    return SynchronousFuture(RouteDecoder.fromLocation(location));
  }

  @override
  RouteInformation restoreRouteInformation(RouteDecoder configuration) {
    return RouteInformation(location: configuration.settings!.name, state: null);
  }
}