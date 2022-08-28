import 'package:yuro/core/core.dart';
import 'package:yuro/logger/logger.dart';
import 'package:yuro/state/state.dart';

import 'instance_builder_factory.dart';

typedef AsyncInstanceBuilder<T> = Future<T> Function();

class YuroInstance {
  static YuroInstance? _instance;

  factory YuroInstance() => _instance ??= YuroInstance._();

  YuroInstance._();

  static final _factories = <String, InstanceBuilderFactory>{};

  late final _logger = Yuro.tag('YuroInstance');

  InstanceBuilderFactory? _getFactory<T>(String? key, String? tag) {
    final newKey = key ?? _getKey(T, tag);
    if (_factories.containsKey(newKey)) {
      return _factories[newKey];
    } else {
      _logger.e('"$newKey" is not registered.');
      return null;
    }
  }

  /// 查找类实例<[T]>
  T find<T>([String? tag]) {
    final key = _getKey(T, tag);
    if (isRegistered<T>(tag)) {
      final factory = _factories[key];
      if (factory == null) {
        throw 'Class "$T"${tag != 'null' ? ' with tag "$tag"' : ''} is not registered.';
      }
      final isInit = factory.isInit;
      T? t;
      if (!isInit) {
        t = factory.getDependency() as T;
        // 如果实例混入了YuroLifeCycleMixin,则启动生命周期
        if (t is YuroLifeCycleMixin) {
          t.onCreate();
          _logger.v('"$T"${tag != 'null' ? ' with tag "$tag"' : ''} has been initialized.');
        }
        factory.isInit = true;
      }
      return t ?? factory.getDependency() as T;
    } else {
      throw '"$T" not find, You must call "put($T())" or "lazyPut(()=>$T())" before calling "find()"';
    }
  }

  /// 将实例<T>注册到内存中并返回实例
  T put<T>(T dependency, {String? tag, bool permanent = false}) {
    _insert(builder: () => dependency, tag: tag, isSingleton: true, permanent: permanent);
    return find<T>(tag);
  }

  /// [put]的异步版本
  Future<T> putAsync<T>(AsyncInstanceBuilder<T> builder, {String? tag, bool permanent = false}) async {
    return put<T>(await builder(), tag: tag, permanent: permanent);
  }

  /// [put]的延迟加载版本
  void lazyPut<T>(InstanceBuilder<T> builder, {String? tag, bool permanent = false, bool keepFactory = false}) {
    _insert(builder: builder, tag: tag, isSingleton: true, permanent: permanent, keepFactory: keepFactory);
  }

  /// 每次都会创建<T>的新实例
  T create<T>(InstanceBuilder<T> builder, {String? tag, bool permanent = false}) {
    _insert(builder: builder, tag: tag, isSingleton: false, permanent: permanent);
    return find<T>(tag);
  }

  /// 删除<T>的实例, [force]为true则被标记为[permanent]的实例也会被删除
  bool delete<T>({String? key, String? tag, bool force = false}) {
    final newKey = key ?? _getKey(T, tag);
    if (!_factories.containsKey(newKey)) {
      _logger.e('"$newKey" has been removed.');
      return false;
    }
    var factory = _factories[newKey];
    // 如果实例不存在,则清理掉key
    if (factory == null) {
      _factories.remove(newKey);
      return false;
    }
    // 如果factory被标记为污染的,则考虑使用之前的版本替换
    if (factory.isDirty && factory.lateRemove != null) factory = factory.lateRemove!;
    if (factory.permanent && !force) {
      _logger.e('"$newKey" has been marked permanent, if you want to delete it, set force to true.');
      return false;
    }
    final dependency = factory.dependency;
    if (dependency is YuroServiceMixin && !force) {
      return false;
    }

    if (dependency is YuroLifeCycleMixin) {
      dependency.onDestroy();
      _logger.v('"$newKey" onDestroy() called.');
    }
    if (factory.keepFactory) {
      factory.dependency = null;
      factory.isInit = false;
      return true;
    } else {
      // 先删除上次的版本
      if (factory.lateRemove != null) {
        factory.lateRemove = null;
        _logger.v('"$newKey" delete from memory.');
        return false;
      } else {
        _factories.remove(newKey);
        _logger.v('"$newKey" delete from memory.');
        return true;
      }
    }
  }

  void deleteAll({bool force = false}) {
    _factories.keys.forEach((e) => delete(key: e, force: force));
  }

  /// 重载
  void reload<T>({String? key, String? tag, bool force = false}) {
    final newKey = key ?? _getKey(T, tag);
    final factory = _factories[newKey];
    if (factory == null) return;

    if (factory.permanent && !force) {
      _logger.e('"$newKey" has been marked permanent, if you want to reload, set force to true.');
      return;
    }
    final dependency = factory.dependency;
    if (dependency is YuroServiceMixin && !force) {
      return;
    }
    if (dependency is YuroLifeCycleMixin) {
      dependency.onDestroy();
      _logger.v('"$newKey" onDestroy() called.');
    }
    factory.dependency = null;
    factory.isInit = false;
    _logger.v('"$newKey" was reloaded.');
  }

  /// 重置实体工厂
  void reset() => _factories.clear();

  /// 标记污染
  void markAsDirty<T>({String? key, String? tag}) {
    final newKey = key ?? _getKey(T, tag);
    if (_factories.containsKey(newKey)) {
      final factory = _factories[newKey];
      if (factory != null && !factory.permanent) {
        factory.isDirty = true;
      }
    }
  }

  /// 检查使用[lazyPut]存放的回调函数是否已经准备好了
  bool isPrepared<T>([String? tag]) {
    final key = _getKey(T, tag);
    final factory = _getFactory<T>(key, tag);
    if (factory == null) return false;
    return !factory.isInit;
  }

  /// 检查类实例<[T]>是否已经注册到内存中
  bool isRegistered<T>([String? tag]) => _factories.containsKey(_getKey(T, tag));

  void _insert<T>({
    required InstanceBuilder<T> builder,
    String? tag,
    bool isSingleton = false,
    bool permanent = false,
    bool keepFactory = false,
  }) {
    final key = _getKey(T, tag);
    InstanceBuilderFactory<T>? builderFactory;
    if (_factories.containsKey(key)) {
      final factory = _factories[key];
      if (factory == null || !factory.isDirty) {
        return;
      } else {
        builderFactory = factory as InstanceBuilderFactory<T>;
      }
    }
    _factories[key] = InstanceBuilderFactory<T>(
      builder: builder,
      tag: tag,
      isSingleton: isSingleton,
      isInit: false,
      lateRemove: builderFactory,
      permanent: permanent,
      keepFactory: keepFactory,
    );
  }

  String _getKey(Type type, String? tag) => '${type.toString()}${tag != null ? '@$tag' : ''}';
}
