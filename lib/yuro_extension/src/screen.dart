import 'dart:ui' as ui show window;

import 'package:flutter/widgets.dart';
import 'package:yuro/yuro_core/yuro_core.dart';

extension ScreenExt on YuroInterface {
  static late _Screen _screen;

  void uiSize(double uiWidth, double uiHeight) => _screen = _Screen(uiWidth, uiHeight);

  double get screenWidth => _screen.width;

  double get screenHeight => _screen.height;

  double get devicePixelRatio => _screen.devicePixelRatio;

  double get textScaleFactor => _screen.textScaleFactor;

  double get statusBarHeight => _screen.statusBarHeight;

  double get bottomBarHeight => _screen.bottomBarHeight;

  double widthConvert(num width) => _screen.getWidth(width);

  double heightConvert(num height) => _screen.getHeight(height);
}

extension ScreenNumExt on num {
  double get w => Yuro.widthConvert(this);

  double get h => Yuro.heightConvert(this);

  double get wp => Yuro.screenWidth * this;

  double get hp => Yuro.screenHeight * this;
}

class _Screen {
  late double _devicePixelRatio;
  late double _textScaleFactor;

  late double _width;
  late double _height;

  late double _statusBarHeight;
  late double _bottomBarHeight;

  late double _scaleWidth;
  late double _scaleHeight;

  _Screen(double uiWidth, double uiHeight) {
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
  double getWidth(num width) => width * _scaleWidth;

  /// 高度方向适配
  double getHeight(num height) => height * _scaleHeight;

  /// 字体适配
  ///
  /// @param allowScale 字体是否跟随系统缩放, 默认true
  ///
  /// TODO 未验证
  num getSp(num fontSize, {bool allowScale = true}) => allowScale ? fontSize * _scaleWidth : fontSize * _scaleWidth / _textScaleFactor;
}
