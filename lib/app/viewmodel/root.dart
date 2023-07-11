import 'package:flutter/widgets.dart';
import 'package:yuro/state/lifecycle.dart';

abstract class RootViewModel extends YuroLifeCycle {
  UniqueKey? appKey;
}
