import 'num_notifier.dart';

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
  NDoubleNotifier([super.value]);

  double? remainder(num other) => value?.remainder(other);

  @override
  double? abs() => value?.abs();

  @override
  double? get sign => value?.sign;
}

extension DoubleNotifierExt on double {
  DoubleNotifier get obs => DoubleNotifier(this);
}
