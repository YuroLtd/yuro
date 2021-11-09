extension IterableExt<T> on Iterable<T> {
  T? get firstOrNull => this.isNotEmpty ? this.first : null;

  T? get lastOrNull => this.isNotEmpty ? this.last : null;
}

extension ListExt<T> on List<T>? {
  bool isNullOrEmpty() => this == null || this!.isEmpty;
}
