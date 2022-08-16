class LruMap<K, V> implements Map<K, V> {
  LruMap();

  final Map<K, _Entry<K, V>> _lruMap = {};

  _Entry<K, V>? _head;
  _Entry<K, V>? _trail;

  @override
  V? operator [](Object? key) {
    _Entry<K, V>? node = _lruMap[key];
    if (node == null) return null;
    _afterNodeAccess(node);
    return node.value;
  }

  // 移动最新访问的Entry到头结点
  void _afterNodeAccess(_Entry<K, V> node) {
    // 如果node是头结点,无需多余操作
    if (node != _head) {
      _Entry<K, V>? n = node, before = n.before, after = n.after;
      n.before = n.after = null;
      n.after = _head!..before = n;
      before!.after = after;
      if (after != null) {
        after.before = before;
      } else {
        _trail = before;
      }
      _head = n;
    }
  }

  @override
  void operator []=(K key, V value) {
    var entry = _lruMap[key];
    if (entry != null) {
      _afterNodeAccess(entry..value = value);
    } else {
      _lruMap[key] = _createNewNode(key, value);
    }
  }

  _Entry<K, V> _createNewNode(K key, V value) {
    var entry = _Entry(key, value);
    if (_head != null) {
      _head!.before = entry..after = _head;
      _head = entry;
    } else {
      _head = _trail = entry;
    }
    return entry;
  }

  @override
  Iterable<K> get keys {
    var keys = <K>[];
    for (_Entry<K, V>? e = _head; e != null; e = e.after) {
      keys.add(e.key);
    }
    return keys;
  }

  @override
  Iterable<V> get values {
    var values = <V>[];
    for (_Entry<K, V>? e = _head; e != null; e = e.after) {
      values.add(e.value);
    }
    return values;
  }

  @override
  Iterable<MapEntry<K, V>> get entries {
    var entries = <MapEntry<K, V>>[];
    for (_Entry<K, V>? e = _head; e != null; e = e.after) {
      entries.add(MapEntry(e.key, e.value));
    }
    return entries;
  }

  @override
  void addAll(Map<K, V> other) {
    other.forEach((key, value) => this[key] = value);
  }

  @override
  void addEntries(Iterable<MapEntry<K, V>> newEntries) {
    for (var e in newEntries) {
      this[e.key] = e.value;
    }
  }

  @override
  V putIfAbsent(K key, V Function() ifAbsent) {
    return _lruMap.putIfAbsent(key, () => _createNewNode(key, ifAbsent())).value;
  }

  @override
  V update(K key, V Function(V value) update, {V Function()? ifAbsent}) {
    return _lruMap.update(
      key,
          (entry) {
        entry.value = update(entry.value);
        _afterNodeAccess(entry);
        return entry;
      },
      ifAbsent: ifAbsent == null ? null : () => _createNewNode(key, ifAbsent.call()),
    ).value;
  }

  @override
  void updateAll(V Function(K key, V value) update) {
    _lruMap.updateAll((key, entry) => entry..value = update(key, entry.value));
  }

  @override
  V? remove(Object? key) {
    var entry = _lruMap[key];
    if (entry != null) _afterNodeRemove(entry);
    return entry?.value;
  }

  V? removeLast() {
    var entry = _trail;
    if (entry != null) _afterNodeRemove(entry);
    return entry?.value;
  }

  @override
  void removeWhere(bool Function(K key, V value) test) {
    _lruMap.removeWhere((key, entry) {
      if (test(key, entry.value)) {
        _afterNodeRemove(entry);
        return true;
      }
      return false;
    });
  }

  void _afterNodeRemove(_Entry<K, V> node) {
    _Entry<K, V>? n = node, before = n.before, after = n.after;
    n.before = n.after = null;
    if (before == null) {
      _head = after;
    } else {
      before.after = after;
    }

    if (after == null) {
      _trail = before;
    } else {
      after.before = before;
    }
  }

  @override
  void clear() {
    _lruMap.clear();
    _head = _trail = null;
  }

  @override
  int get length => _lruMap.length;

  @override
  bool get isEmpty => _lruMap.isEmpty;

  @override
  bool get isNotEmpty => _lruMap.isNotEmpty;

  @override
  bool containsKey(Object? key) => keys.contains(key);

  @override
  bool containsValue(Object? value) => values.contains(value);

  @override
  // ignore: avoid_function_literals_in_foreach_calls
  void forEach(void Function(K key, V value) action) => entries.forEach((e) => action(e.key, e.value));

  @override
  Map<RK, RV> cast<RK, RV>() => throw UnimplementedError();

  @override
  Map<K2, V2> map<K2, V2>(MapEntry<K2, V2> Function(K key, V value) convert) => throw UnimplementedError();
}

class _Entry<K, V> {
  _Entry(this.key, this.value);

  final K key;
  V value;

  _Entry<K, V>? before;
  _Entry<K, V>? after;
}
