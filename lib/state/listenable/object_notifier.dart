import 'package:flutter/widgets.dart';
import 'package:yuro/yuro.dart';

class ObjectNotifier<T> extends ValueNotifier<T> with ValueNotifierMixin {
  ObjectNotifier(super.value);
}

extension ObjectNotifierExt<T> on T {
  ObjectNotifier<T> get obs => ObjectNotifier<T>(this);
}
