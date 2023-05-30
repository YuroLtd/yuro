import 'package:flutter/widgets.dart';

extension ValueNotifierExt<T> on T {
  ValueNotifier<T> get obs => ValueNotifier<T>(this);
}
