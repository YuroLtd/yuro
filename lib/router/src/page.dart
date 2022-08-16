// ignore_for_file: overridden_fields

import 'package:flutter/widgets.dart';
import 'package:yuro/router/router.dart';
import 'package:yuro/util/util.dart';

typedef PageBuilder = Widget Function();

typedef PagePredicate = bool Function(YuroPage page);

class YuroPage<T> extends Page<T> {
  /// 路由名称
  @override
  final String name;

  /// 页面构造器
  final PageBuilder builder;

  /// 路由中间件
  final List<Middleware>? middlewares;

  /// 次级界面
  final List<YuroPage>? children;

  /// 页面未找到时重定向的页面, 不为空时优于[YuroApp.unknownPage]显示
  final YuroPage? unknownPage;

  /// 根据[name]生成路径的正则表达式,不推荐主动使用该属性
  final PathDecoder path;

  final bool maintainState;
  final bool fullscreenDialog;
  final Color? barrierColor;
  final String? barrierLabel;
  final Duration transitionDuration;
  final Duration reverseTransitionDuration;
  final bool opaque;
  final bool barrierDismissible;

  YuroPage({
    LocalKey? key,
    required this.name,
    required this.builder,
    this.middlewares,
    super.arguments,
    this.children,
    this.unknownPage,
    PathDecoder? path,
    //
    super.restorationId,
    this.maintainState = true,
    this.fullscreenDialog = false,
    this.barrierColor,
    this.barrierLabel,
    this.transitionDuration = const Duration(milliseconds: 300),
    this.reverseTransitionDuration = const Duration(milliseconds: 300),
    this.opaque = true,
    this.barrierDismissible = false,
  })  : assert(name.startsWith('/'), 'Route [$name] must start with a slash: /$name'),
        path = path ?? PathDecoder.fromName(name),
        super(key: key ?? ValueKey(name));

  YuroPage<T> copy({
    LocalKey? key,
    String? name,
    PageBuilder? builder,
    Object? arguments,
    List<Middleware>? middlewares,
    List<YuroPage>? children,
    YuroPage? unknownPage,
    PathDecoder? path,
    String? restorationId,
    bool? maintainState,
    bool? fullscreenDialog,
    Color? barrierColor,
    String? barrierLabel,
    Duration? transitionDuration,
    Duration? reverseTransitionDuration,
    bool? opaque,
    bool? barrierDismissible,
  }) =>
      YuroPage<T>(
        key: key ?? this.key,
        name: name ?? this.name,
        builder: builder ?? this.builder,
        arguments: arguments ?? this.arguments,
        middlewares: middlewares ?? this.middlewares,
        children: children ?? this.children,
        unknownPage: unknownPage ?? this.unknownPage,
        path: path ?? this.path,
        //
        restorationId: restorationId ?? this.restorationId,
        maintainState: maintainState ?? this.maintainState,
        fullscreenDialog: fullscreenDialog ?? this.fullscreenDialog,
        barrierColor: barrierColor ?? this.barrierColor,
        barrierLabel: barrierLabel ?? this.barrierLabel,
        transitionDuration: transitionDuration ?? this.transitionDuration,
        reverseTransitionDuration: reverseTransitionDuration ?? this.reverseTransitionDuration,
        opaque: opaque ?? this.opaque,
        barrierDismissible: barrierDismissible ?? this.barrierDismissible,
      );

  @override
  Route<T> createRoute(BuildContext context) => PageRedirect(this, unknownPage).pageRoute();

  @override
  int get hashCode => key.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is YuroPage<T> && other.key == key;
  }
}

@immutable
class PathDecoder {
  final RegExp regexp;
  final List<String> keys;

  const PathDecoder(this.regexp, this.keys);

  factory PathDecoder.fromName(String name) {
    final keys = <String?>[];
    String _replace(Match match) {
      final sb = StringBuffer('(?:');
      if (match[1] != null) sb.write('\\.');
      sb.write('([\\w%+-._~!\$&\'()*,;=:@]+))');
      if (match[3] != null) sb.write('?');
      keys.add(match[2]);
      return sb.toString();
    }

    final newPath = name.replaceAllMapped(RegExp(r'(\.)?:(\w+)(\?)?'), _replace).replaceAll('//', '/');
    return PathDecoder(RegExp('^$newPath\$'), keys.whereNotNull().toList());
  }

  @override
  int get hashCode => regexp.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PathDecoder && other.regexp == regexp;
  }
}
