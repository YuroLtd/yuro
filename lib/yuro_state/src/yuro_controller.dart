import 'package:flutter/foundation.dart';
import 'package:yuro/yuro_core/yuro_core.dart';

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