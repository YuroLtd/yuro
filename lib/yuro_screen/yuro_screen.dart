library yuro_screen;

import 'package:yuro/yuro_core/yuro_core.dart';

import 'src/screen.dart';

extension YuroScreenExt on YuroInterface {
  static late Screen _screen;

  void uiSize(double uiWidth, double uiHeight) => _screen = Screen(uiWidth, uiHeight);

  Screen get screen => _screen;
}

extension ScreenNumExt on num {
  double get w => Yuro.screen.setWidth(this);

  double get h => Yuro.screen.setHeight(this);

  double get sw => Yuro.screen.width * this;

  double get sh => Yuro.screen.height * this;

  double get sp => Yuro.screen.setSP(this);
}
