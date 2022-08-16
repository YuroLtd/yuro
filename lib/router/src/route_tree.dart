import 'package:flutter/widgets.dart';
import 'package:yuro/util/util.dart';
import 'package:yuro/router/router.dart';

/// 路由树,负责页面的添加与匹配
class RouteTree {
  final _routes = <YuroPage>[];

  List<YuroPage> get routes => List.unmodifiable(_routes);

  /// 添加一组页面
  void addPages(List<YuroPage> pages) {
    for (final element in pages) {
      addPage(element);
    }
  }

  /// 添加单个页面
  void addPage(YuroPage page) {
    _routes.add(page);

    final children = _flattenPage(page);
    if (children.isNullOrEmpty) return;

    for (final element in children!) {
      addPage(element);
    }
  }

  // 扁平化子级页面, 拼接父子路径, 继承父页面的中间件
  List<YuroPage>? _flattenPage(YuroPage root) => root.children?.map((e) {
        final newName = (root.name + e.name).replaceAll('//', '/');
        return e.copy(
            // 重置key
            key: ValueKey(newName),
            // 继承父页面的路径
            name: newName,
            // 继承父页面的中间件
            middlewares: e.middlewares.merge(root.middlewares),
            path: PathDecoder.fromName(newName));
      }).toList();

  /// 移除单个页面
  void removePage(YuroPage page) => _routes.remove(page);

  /// 根据[route]查找匹配的页面,并获取参数
  RouteDecoder matchRoute(String route, [PageSettings? settings]) {
    final uri = Uri.parse(route);
    var matchPage = _routes.firstWhereOrNull((e) => e.path.regexp.hasMatch(uri.path));
    // 路由参数
    settings?.queryParams = Map<String, String>.from(uri.queryParameters);
    if (matchPage != null) {
      // 解析路径参数
      settings?.params = _parsePathParams(uri.path, matchPage.path);
      matchPage = matchPage.copy(key: ValueKey(route), name: route, arguments: settings);
    }
    return RouteDecoder(page: matchPage, settings: settings);
  }

  // 解析路径中的参数,不包括查询参数
  Map<String, String> _parsePathParams(String path, PathDecoder decoder) {
    final params = <String, String>{};
    final paramsMatch = decoder.regexp.firstMatch(path);
    if (paramsMatch != null) {
      decoder.keys.forEachIndexed((index, element) {
        params[element] = paramsMatch[index + 1]!;
      });
    }
    return params;
  }
}
