import 'package:flutter/foundation.dart';
import 'package:provider/single_child_widget.dart';
import 'package:yuro/yuro_core/yuro_core.dart';
import 'package:yuro/yuro_state/yuro_state.dart';

abstract class YuroController extends YuroLifeCycle with ChangeNotifier {
  bool disposed = false;

  @override
  void notifyListeners() {
    if (!disposed) super.notifyListeners();
  }

  @override
  void dispose() {
    disposed = true;
    super.dispose();
  }
}

extension YuroControllerExt on ChangeNotifier {
  ChangeNotifierProvider get create => ChangeNotifierProvider(create: (_) => this,lazy: false);
}
