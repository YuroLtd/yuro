import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:collection/collection.dart';

extension ListNotifierExt<T> on List<T> {
  ListNotifier<T> get obs => ListNotifier(this);
}

class ListNotifier<E> extends ListListenable<E> {
  ListNotifier(List<E> list) : super(list);

  set value(List<E> list) {
    if (DeepCollectionEquality().equals(value, list)) return;
    _value = list;
    notifyListeners();
  }

  @override
  void operator []=(int index, E value) {
    super[index] = value;
    notifyListeners();
  }

  @override
  set length(int newLength) {
    super.length = newLength;
    notifyListeners();
  }

  @override
  set first(E value) {
    super.first = value;
    notifyListeners();
  }

  @override
  set last(E value) {
    super.last = value;
    notifyListeners();
  }

  @override
  void add(E value) {
    super.add(value);
    notifyListeners();
  }

  @override
  void addAll(Iterable<E> iterable) {
    super.addAll(iterable);
    notifyListeners();
  }

  @override
  void insert(int index, E element) {
    super.insert(index, element);
    notifyListeners();
  }

  @override
  void insertAll(int index, Iterable<E> iterable) {
    super.insertAll(index, iterable);
    notifyListeners();
  }

  @override
  void setAll(int index, Iterable<E> iterable) {
    super.setAll(index, iterable);
    notifyListeners();
  }

  @override
  void setRange(int start, int end, Iterable<E> iterable, [int skipCount = 0]) {
    super.setRange(start, end, iterable, skipCount);
    notifyListeners();
  }

  @override
  bool remove(Object? value) {
    final result = super.remove(value);
    notifyListeners();
    return result;
  }

  @override
  E removeAt(int index) {
    final result = super.removeAt(index);
    notifyListeners();
    return result;
  }

  @override
  E removeLast() {
    final result = super.removeLast();
    notifyListeners();
    return result;
  }

  @override
  void removeRange(int start, int end) {
    super.removeRange(start, end);
    notifyListeners();
  }

  @override
  void removeWhere(bool Function(E element) test) {
    super.removeWhere(test);
    notifyListeners();
  }

  @override
  void clear() {
    super.clear();
    notifyListeners();
  }

  @override
  void retainWhere(bool Function(E element) test) {
    super.retainWhere(test);
    notifyListeners();
  }

  @override
  void fillRange(int start, int end, [E? fillValue]) {
    super.fillRange(start, end, fillValue);
    notifyListeners();
  }

  @override
  void replaceRange(int start, int end, Iterable<E> replacements) {
    super.replaceRange(start, end, replacements);
    notifyListeners();
  }

  @override
  void sort([int Function(E a, E b)? compare]) {
    super.sort(compare);
    notifyListeners();
  }
}

class ListListenable<E> extends IterableListenable<List<E>, E> implements List<E> {
  ListListenable(List<E> list) : super(list);

  @override
  List<E> operator +(List<E> other) => _value + other;

  @override
  E operator [](int index) => _value[index];

  @override
  void operator []=(int index, E value) => _value[index] = value;

  @override
  void add(E value) => _value.add(value);

  @override
  void addAll(Iterable<E> iterable) => _value.addAll(iterable);

  @override
  Map<int, E> asMap() => _value.asMap();

  @override
  void clear() => value.clear();

  @override
  List<R> cast<R>() => _value.cast<R>();

  @override
  void fillRange(int start, int end, [E? fillValue]) => _value.fillRange(start, end, fillValue);

  @override
  set first(E value) => _value.first = value;

  @override
  Iterable<E> getRange(int start, int end) => _value.getRange(start, end);

  @override
  int indexOf(E element, [int start = 0]) => _value.indexOf(element, start);

  @override
  int indexWhere(bool Function(E element) test, [int start = 0]) => _value.indexWhere(test, start);

  @override
  void insert(int index, E element) => _value.insert(index, element);

  @override
  void insertAll(int index, Iterable<E> iterable) => _value.insertAll(index, iterable);

  @override
  set last(E value) => _value.last = value;

  @override
  int lastIndexOf(E element, [int? start]) => _value.lastIndexOf(element, start);

  @override
  int lastIndexWhere(bool Function(E element) test, [int? start]) => _value.lastIndexWhere(test, start);

  @override
  set length(int newLength) => _value.length = newLength;

  @override
  bool remove(Object? value) => _value.remove(value);

  @override
  E removeAt(int index) => _value.removeAt(index);

  @override
  E removeLast() => _value.removeLast();

  @override
  void removeRange(int start, int end) => _value.removeRange(start, end);

  @override
  void removeWhere(bool Function(E element) test) => _value.removeWhere(test);

  @override
  void replaceRange(int start, int end, Iterable<E> replacements) => _value.replaceRange(start, end, replacements);

  @override
  void retainWhere(bool Function(E element) test) => _value.retainWhere(test);

  @override
  Iterable<E> get reversed => _value.reversed;

  @override
  void setAll(int index, Iterable<E> iterable) => _value.setAll(index, iterable);

  @override
  void setRange(int start, int end, Iterable<E> iterable, [int skipCount = 0]) => _value.setRange(start, end, iterable);

  @override
  void shuffle([Random? random]) => _value.shuffle(random);

  @override
  void sort([int Function(E a, E b)? compare]) => _value.sort(compare);

  @override
  List<E> sublist(int start, [int? end]) => _value.sublist(start, end);
}

class IterableListenable<T extends Iterable<E>, E> extends ChangeNotifier implements Iterable<E>, ValueListenable<T> {
  IterableListenable(T list) : _value = list;

  T _value;

  @override
  T get value => _value;

  @override
  E get first => _value.first;

  @override
  E get last => _value.last;

  @override
  int get length => _value.length;

  @override
  bool get isEmpty => _value.isEmpty;

  @override
  bool get isNotEmpty => _value.isNotEmpty;

  @override
  Iterator<E> get iterator => _value.iterator;

  @override
  bool any(bool Function(E element) test) => _value.any(test);

  @override
  Iterable<R> cast<R>() => _value.cast<R>();

  @override
  bool contains(Object? element) => _value.contains(element);

  @override
  E elementAt(int index) => _value.elementAt(index);

  @override
  bool every(bool Function(E element) test) => _value.every(test);

  @override
  Iterable<T> expand<T>(Iterable<T> Function(E element) f) => _value.expand(f);

  @override
  E firstWhere(bool Function(E element) test, {E Function()? orElse}) => _value.firstWhere(test, orElse: orElse);

  @override
  T fold<T>(T initialValue, T Function(T previousValue, E element) combine) => _value.fold(initialValue, combine);

  @override
  Iterable<E> followedBy(Iterable<E> other) => _value.followedBy(other);

  @override
  void forEach(void Function(E element) f) => _value.forEach(f);

  @override
  String join([String separator = ""]) => _value.join(separator);

  @override
  E lastWhere(bool Function(E element) test, {E Function()? orElse}) => _value.lastWhere(test, orElse: orElse);

  @override
  Iterable<T> map<T>(T Function(E e) f) => _value.map(f);

  @override
  E reduce(E Function(E value, E element) combine) => _value.reduce(combine);

  @override
  E get single => _value.single;

  @override
  E singleWhere(bool Function(E element) test, {E Function()? orElse}) => _value.singleWhere(test, orElse: orElse);

  @override
  Iterable<E> where(bool Function(E element) test) => _value.where(test);

  @override
  Iterable<T> whereType<T>() => _value.whereType<T>();

  @override
  Iterable<E> skip(int count) => _value.skip(count);

  @override
  Iterable<E> skipWhile(bool Function(E value) test) => _value.skipWhile(test);

  @override
  Iterable<E> take(int count) => _value.take(count);

  @override
  Iterable<E> takeWhile(bool Function(E value) test) => _value.takeWhile(test);

  @override
  List<E> toList({bool growable = true}) => _value.toList(growable: growable);

  @override
  Set<E> toSet() => _value.toSet();

  @override
  bool operator ==(Object other) => _value == other;

  @override
  int get hashCode => _value.hashCode;

  @override
  String toString() => _value.toString();
}
