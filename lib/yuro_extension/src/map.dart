extension MapExt<K, V> on Map<K, V> {
  String signStr() {
    var sb = StringBuffer();
    this.forEach((key, value) {
      sb
        ..write(key)
        ..write('=')
        ..write(value)
        ..write('&');
    });
    return sb.toString().substring(0, sb.length - 1);
  }

  Map<K, V> where(bool Function(K k, V v) test) {
    final list = <MapEntry<K, V>>[];
    entries.forEach((element) {
      if (test(element.key, element.value)) list.add(element);
    });
    return Map.fromEntries(list);
  }
}
