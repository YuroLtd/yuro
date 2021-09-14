import 'package:objectbox/objectbox.dart';
import 'package:yuro/yuro_core/yuro_core.dart';

extension ObjectBoxExt on YuroInterface {
  static Store? _objectboxStore;

  Store get objectboxStore {
    assert(_objectboxStore != null, '须在`runYuroApp()`方法中初始化openObjectBox');
    return _objectboxStore!;
  }

  set objectboxStore(Store store) {
    _objectboxStore = store;
  }
}

abstract class Dao<T> {
  Box<T> _box = Yuro.objectboxStore.box<T>();

  Box<T> get box => _box;
}
