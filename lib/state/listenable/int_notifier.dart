import 'num_notifier.dart';

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
  NIntNotifier([super.value]);

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

extension IntNotifierExt on int {
  IntNotifier get obs => IntNotifier(this);
}
