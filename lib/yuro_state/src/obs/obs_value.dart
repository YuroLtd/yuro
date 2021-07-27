import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Obs<T> extends StatelessWidget {
  const Obs({Key? key, required this.valueListenable, required this.builder, this.child}) : super(key: key);

  final ValueNotifier<T> valueListenable;

  final Widget? child;

  final ValueWidgetBuilder<T> builder;

  @override
  Widget build(BuildContext context) =>
      ValueListenableBuilder<T>(valueListenable: valueListenable, builder: builder, child: child);
}

extension ObsExt<T> on T {
  ValueNotifier<T> get obs => ValueNotifier<T>(this);
}