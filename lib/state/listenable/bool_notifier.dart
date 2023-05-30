import 'package:flutter/foundation.dart';

class BoolNotifier extends ValueNotifier<bool> {
  BoolNotifier(super.value);

  bool operator &(bool other) => other && value;

  bool operator |(bool other) => other || value;

  bool operator ^(bool other) => !other == value;

  @override
  String toString() => value ? "true" : "false";
}

extension BoolNotifierExt on bool {
  BoolNotifier get obs => BoolNotifier(this);
}

class NBoolNotifier extends ValueNotifier<bool?> {
  NBoolNotifier([super.value]);

  bool operator &(bool other) => other && (value ?? false);

  bool operator |(bool other) => other || (value ?? false);

  bool operator ^(bool other) => !other == (value ?? false);

  @override
  String toString() => (value ?? false) ? "true" : "false";
}
