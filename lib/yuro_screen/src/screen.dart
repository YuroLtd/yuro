import 'dart:math';
import 'dart:ui' as ui show window;

import 'package:flutter/widgets.dart';

class Screen {
  late double _devicePixelRatio;
  late double _textScaleFactor;

  late double _width;
  late double _height;

  late double _statusBarHeight;
  late double _bottomBarHeight;

  late double _scaleWidth;
  late double _scaleHeight;

  Screen(double uiWidth, double uiHeight) {
    final window = MediaQueryData.fromWindow(ui.window);
    _devicePixelRatio = window.devicePixelRatio;
    _textScaleFactor = window.textScaleFactor;

    _width = window.size.width;
    _height = window.size.height;

    _statusBarHeight = window.padding.top;
    _bottomBarHeight = window.padding.bottom;

    _scaleWidth = _width / uiWidth;
    _scaleHeight = _height / uiHeight;
  }

  /// 屏幕宽度
  double get width => _width;

  /// 屏幕高度
  double get height => _height;

  /// 屏幕像素密度
  double get devicePixelRatio => _devicePixelRatio;

  /// 字体缩放比例
  double get textScaleFactor => _textScaleFactor;

  /// 状态栏高度
  double get statusBarHeight => _statusBarHeight;

  /// 底部安全高度
  double get bottomBarHeight => _bottomBarHeight;

  /// 宽度方向适配
  double setWidth(num width) => width * _scaleWidth;

  /// 高度方向适配
  double setHeight(num height) => height * _scaleHeight;

  /// 字体适配
  double setSP(num fontSize) => fontSize * min(_scaleWidth, _scaleHeight);
}
