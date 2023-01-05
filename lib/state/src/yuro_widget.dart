import 'package:flutter/material.dart';
import 'package:yuro/core/core.dart';
import 'package:yuro/instance/instance.dart';

import 'yuro_controller.dart';

abstract class YuroWidget<T extends YuroController> extends StatelessWidget {
  const YuroWidget({super.key});

  String? get tag => null;

  T get controller => Yuro.find<T>(tag);
}
