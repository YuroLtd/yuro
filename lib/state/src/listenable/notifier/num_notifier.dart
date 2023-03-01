import 'object_notifier.dart';

class NumNotifier<T extends num> extends ObjectNotifier<T> implements Comparable<T> {
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

class NNumNotifier<T extends num?> extends ObjectNotifier<T?> implements Comparable<num> {
  NNumNotifier([T? value]) : super(value);

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

class IntNotifier extends NumNotifier<int> {
  IntNotifier(super.value);

  int operator &(int other) => value & other;

  int operator |(int other) => value | other;

  int operator ^(int other) => value ^ other;

  int operator ~() => ~value;

  int operator <<(int shiftAmount) => value << shiftAmount;

  int operator >>(int shiftAmount) => value >> shiftAmount;

  int operator >>>(int shiftAmount) => value >>> shiftAmount;

  int modPow(int exponent, int modulus) => value.modPow(exponent, modulus);

  int modInverse(int modulus) => value.modInverse(modulus);

  int gcd(int other) => value.gcd(other);

  bool get isEven => value.isEven;

  bool get isOdd => value.isOdd;

  int get bitLength => value.bitLength;

  int toUnsigned(int width) => value.toUnsigned(width);

  int toSigned(int width) => value.toSigned(width);

  @override
  int operator -() => -value;

  @override
  int abs() => value.abs();

  @override
  int get sign => value.sign;

  String toRadixString(int radix) => value.toRadixString(radix);
}

class NIntNotifier extends NNumNotifier<int?> {
  NIntNotifier([int? value]) : super(value);

  int? operator &(int other) => value == null ? null : value! & other;

  int? operator |(int other) => value == null ? null : value! | other;

  int? operator ^(int other) => value == null ? null : value! ^ other;

  int? operator ~() => value == null ? null : ~value!;

  int? operator <<(int shiftAmount) => value == null ? null : value! << shiftAmount;

  int? operator >>(int shiftAmount) => value == null ? null : value! >> shiftAmount;

  int? operator >>>(int shiftAmount) => value == null ? null : value! >>> shiftAmount;

  int? modPow(int exponent, int modulus) => value?.modPow(exponent, modulus);

  int? modInverse(int modulus) => value?.modInverse(modulus);

  int? gcd(int other) => value?.gcd(other);

  bool? get isEven => value?.isEven;

  bool? get isOdd => value?.isOdd;

  int? get bitLength => value?.bitLength;

  int? toUnsigned(int width) => value?.toUnsigned(width);

  int? toSigned(int width) => value?.toSigned(width);

  @override
  int? operator -() => value == null ? null : -value!;

  @override
  int? abs() => value?.abs();

  @override
  int? get sign => value?.sign;

  String? toRadixString(int radix) => value?.toRadixString(radix);
}

class DoubleNotifier extends NumNotifier<double> {
  DoubleNotifier(super.value);

  double remainder(num other) => value.remainder(other);

  @override
  double operator -() => -value;

  @override
  double abs() => value.abs();

  @override
  double get sign => value.sign;
}

class NDoubleNotifier extends NNumNotifier<double?> {
  NDoubleNotifier([double? value]) : super(value);

  double? remainder(num other) => value?.remainder(other);

  @override
  double? abs() => value?.abs();

  @override
  double? get sign => value?.sign;
}

extension IntNotifierExt on int {
  IntNotifier get obs => IntNotifier(this);
}

extension DoubleNotifierExt on double {
  DoubleNotifier get obs => DoubleNotifier(this);
}
