import 'package:yuro/core/core.dart';

import 'src/instance.dart';
import 'src/instance_builder_factory.dart';

extension InstanceExt on YuroInterface {
  T find<T>([String? tag]) => YuroInstance().find<T>(tag);

  T put<T>(T dependency, {String? tag, bool permanent = false}) =>
      YuroInstance().put<T>(dependency, tag: tag, permanent: permanent);

  Future<T> putAsync<T>(AsyncInstanceBuilder<T> builder, {String? tag, bool permanent = false}) =>
      YuroInstance().putAsync<T>(builder, tag: tag, permanent: permanent);

  void lazyPut<T>(InstanceBuilder<T> builder, {String? tag, bool permanent = false, bool keepFactory = false}) =>
      YuroInstance().lazyPut<T>(builder, tag: tag, permanent: permanent, keepFactory: keepFactory);

  T create<T>(InstanceBuilder<T> builder, {String? tag, bool permanent = false}) =>
      YuroInstance().create<T>(builder, tag: tag, permanent: permanent);

  bool delete<T>({String? key, String? tag, bool force = false}) =>
      YuroInstance().delete<T>(key: key, tag: tag, force: force);

  void reload<T>({String? key, String? tag, bool force = false}) =>
      YuroInstance().reload<T>(key: key, tag: tag, force: force);

  bool isRegistered<T>([String? tag]) => YuroInstance().isRegistered<T>(tag);

  bool isPrepared<T>([String? tag]) => YuroInstance().isPrepared<T>(tag);

  void resetInstance() => YuroInstance().reset();
}
