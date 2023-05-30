import 'package:flutter/foundation.dart';

class NumNotifier<T extends num> extends ValueNotifier<T> implements Comparable<T> {
  NumNotifier(super.value);

  @override
  int compareTo(num other) => value.compareTo(other);

  num operator +(num other) => value + other;

  num operator -(num other) => value - other;

  num operator *(num other) => value * other;

  double operator /(num other) => value / other;

  num operator %(num other) => value % other;

  int operator ~/(num other) => value ~/ other;

  num operator -() => -value;

  bool operator <(num other) => value < other;

  bool operator <=(num other) => value <= other;

  bool operator >(num other) => value > other;

  bool operator >=(num other) => value >= other;

  bool get isNaN => value.isNaN;

  bool get isNegative => value.isNegative;

  bool get isInfinite => value.isInfinite;

  bool get isFinite => value.isFinite;

  num abs() => value.abs();

  num get sign => value.sign;

  int round() => value.round();

  int floor() => value.floor();

  int ceil() => value.ceil();

  int truncate() => value.truncate();

  double roundToDouble() => value.roundToDouble();

  double floorToDouble() => value.floorToDouble();

  double ceilToDouble() => value.ceilToDouble();

  double truncateToDouble() => value.truncateToDouble();

  num clamp(num lowerLimit, num upperLimit) => value.clamp(lowerLimit, upperLimit);

  int toInt() => value.toInt();

  double toDouble() => value.toDouble();

  String toStringAsFixed(int fractionDigits) => value.toStringAsFixed(fractionDigits);

  String toStringAsExponential([int? fractionDigits]) => value.toStringAsExponential(fractionDigits);

  String toStringAsPrecision(int precision) => value.toStringAsPrecision(precision);

  @override
  String toString() => value.toString();
}

class NNumNotifier<T extends num?> extends ValueNotifier<T?> implements Comparable<num> {
  NNumNotifier([super.value]);

  @override
  int compareTo(num other) => value?.compareTo(other) ?? -1;

  num? operator +(num other) => value == null ? null : value! + other;

  num? operator -(num other) => value == null ? null : value! - other;

  num? operator *(num other) => value == null ? null : value! * other;

  double? operator /(num other) => value == null ? null : value! / other;

  num? operator %(num other) => value == null ? null : value! % other;

  int? operator ~/(num other) => value == null ? null : value! ~/ other;

  num? operator -() => value == null ? null : -value!;

  bool? operator <(num other) => value == null ? null : value! < other;

  bool? operator <=(num other) => value == null ? null : value! <= other;

  bool? operator >(num other) => value == null ? null : value! > other;

  bool? operator >=(num other) => value == null ? null : value! >= other;

  bool? get isNaN => value?.isNaN;

  bool? get isNegative => value?.isNegative;

  bool? get isInfinite => value?.isInfinite;

  bool? get isFinite => value?.isFinite;

  num? abs() => value?.abs();

  num? get sign => value?.sign;

  int? round() => value?.round();

  int? floor() => value?.floor();

  int? ceil() => value?.ceil();

  int? truncate() => value?.truncate();

  double? roundToDouble() => value?.roundToDouble();

  double? floorToDouble() => value?.floorToDouble();

  double? ceilToDouble() => value?.ceilToDouble();

  double? truncateToDouble() => value?.truncateToDouble();

  num? clamp(num lowerLimit, num upperLimit) => value?.clamp(lowerLimit, upperLimit);

  int? toInt() => value?.toInt();

  double? toDouble() => value?.toDouble();

  String? toStringAsFixed(int fractionDigits) => value?.toStringAsFixed(fractionDigits);

  String? toStringAsExponential([int? fractionDigits]) => value?.toStringAsExponential(fractionDigits);

  String? toStringAsPrecision(int precision) => value?.toStringAsPrecision(precision);

  @override
  String toString() => value.toString();
}
