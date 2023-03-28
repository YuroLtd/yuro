import 'dart:ui' as ui show window;

import 'package:flutter/widgets.dart';
import 'package:yuro/core/core.dart';

class Screen {
  Screen._([double? width, double? height]) {
    final window = MediaQueryData.fromWindow(ui.window);
    _devicePixelRatio = window.devicePixelRatio;
    _textScaleFactor = window.textScaleFactor;

    _width = window.size.width;
    _height = window.size.height;

    _statusBarHeight = window.padding.top;
    _bottomBarHeight = window.padding.bottom;

    _scaleWidth = _width / (width ?? _width);
    _scaleHeight = _height / (height ?? _height);
  }

  late final double _devicePixelRatio;
  late final double _textScaleFactor;

  late final double _width;
  late final double _height;

  late final double _statusBarHeight;
  late final double _bottomBarHeight;

  late final double _scaleWidth;
  late final double _scaleHeight;

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
}

extension ScreenExt on YuroInterface {
  static Screen _instance = Screen._();

  /// 获取屏幕信息
  Screen get screen => _instance;

  /// 修改设计图尺寸
  void changeUiSize(Size size) => _instance = Screen._(size.width, size.height);

  /// 获取屏幕宽度(dp)
  double get width => screen.width;

  /// 获取屏幕高度(dp)
  double get height => screen.height;
}

extension ScreenNumExt on num {
  double get w => Yuro.screen.setWidth(this);

  double get h => Yuro.screen.setHeight(this);

  double get sw => Yuro.screen.width * this;

  double get sh => Yuro.screen.height * this;
}
