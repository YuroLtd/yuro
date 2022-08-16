import 'package:collection/collection.dart';

extension IterableExt<T> on Iterable<T> {
  bool equals(Iterable<T> other) => const DeepCollectionEquality().equals(this, other);
}

extension ListExt<T> on List<T> {
  List<T> reverse() => reversed.toList();
}

extension NullListExt<T> on List<T>? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  bool get notNullOrEmpty => !isNullOrEmpty;

  List<T>? merge(List<T>? other) {
    if (other.notNullOrEmpty) {
      return List.of(this ?? [])..addAll(other!);
    }
    return this;
  }
}
