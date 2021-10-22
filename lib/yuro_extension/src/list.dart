extension ListExt<T> on List<T>? {
  bool isNullOrEmpty() => this == null || this!.isEmpty;
}
