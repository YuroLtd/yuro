import 'object_notifier.dart';

class BoolNotifier extends ObjectNotifier<bool> {
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

class NBoolNotifier extends ObjectNotifier<bool?> {
  NBoolNotifier([bool? value]) : super(value);

  bool operator &(bool other) => other && (value ?? false);

  bool operator |(bool other) => other || (value ?? false);

  bool operator ^(bool other) => !other == (value ?? false);

  @override
  String toString() => (value ?? false) ? "true" : "false";
}

