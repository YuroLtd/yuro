import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Obs<T> extends StatelessWidget {
  const Obs({Key? key, required this.value, required this.builder, this.child}) : super(key: key);

  final ValueNotifier<T> value;

  final Widget? child;

  final ValueWidgetBuilder<T> builder;

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<T>(valueListenable: value, builder: builder, child: child);
}

extension ObsExt<T> on T{
  ValueNotifier<T> get obs => ValueNotifier<T>(this);
}