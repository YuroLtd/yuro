extension ListExt<T> on List<T> {
  List<T> reverse() => reversed.toList();
}

extension NullListExt<T> on List<T>? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  bool get notNullOrEmpty => this != null && this!.isNotEmpty;

  List<T>? merge(List<T>? other) {
    if (other.notNullOrEmpty) {
      return List.of(this ?? [])..addAll(other!);
    }
    return this;
  }
}
