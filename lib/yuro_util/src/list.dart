import 'dart:convert';

extension IterableExt<T> on Iterable<T> {
  T? get firstOrNull => isNotEmpty ? first : null;

  T? get lastOrNull => isNotEmpty ? last : null;
}

extension ListExt<T> on List<T> {
  List<T> reverse() => reversed.toList();

  String toJson() => json.encode(this);
}

extension List2Ext<T> on List<T>? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;
}
