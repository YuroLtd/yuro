import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:yuro/core/core.dart';
import 'package:yuro/router/router.dart';

class RouteDecoder {
  final PageSettings? settings;
  YuroPage? page;
  Completer? completer;

  RouteDecoder({required this.page, required this.settings});

  factory RouteDecoder.fromLocation(String location) {
    final settings = PageSettings.fromUrl(location);
    return Yuro.routeTree.matchRoute(location, settings);
  }

  Map<String, String> get params => Map.of(settings?.params ?? {});

  Map<String, String> get queryParams => Map.of(settings?.queryParams ?? {});

  T? arguments<T>() => settings?.arguments as T?;

  @override
  int get hashCode => page.hashCode ^ settings.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is RouteDecoder ? other.page == page && other.arguments == arguments : false;
  }
}

/// 页面配置
class PageSettings extends RouteSettings {
  PageSettings(this.uri, {super.arguments});

  factory PageSettings.fromUrl(String url, [Object? arguments]) => PageSettings(Uri.parse(url), arguments: arguments);

  final Uri uri;

  @override
  String get name => uri.toString();

  /// 页面路径
  String get path => uri.path;

  /// 路径参数
  final _params = <String, String>{};

  Map<String, String> get params => Map.unmodifiable(_params);

  set params(Map<String, String> map) {
    _params.clear();
    _params.addAll(map);
  }

  /// 路径查询参数
  final _queryParams = <String, String>{};

  Map<String, String> get queryParams => Map.unmodifiable(_queryParams);

  set queryParams(Map<String, String> map) {
    _queryParams.clear();
    _queryParams.addAll(map);
  }

  @override
  int get hashCode => uri.hashCode ^ arguments.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PageSettings ? other.uri == uri && other.arguments == arguments : false;
  }
}
