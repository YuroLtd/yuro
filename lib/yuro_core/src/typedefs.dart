typedef VoidFunction = void Function();

typedef ValueFunction<T> = void Function(T value);

typedef TestFunction<T> = bool Function(T t);

typedef TestMapFunction<K, V> = bool Function(K k, V v);
