import 'dart:ui' as ui show window;

import 'package:flutter/widgets.dart';
import 'package:yuro/core/core.dart';

class Screen {
  static Size? uiSize;

  Screen._() {
    final window = MediaQueryData.fromWindow(ui.window);
    _devicePixelRatio = window.devicePixelRatio;

    _width = window.size.width;
    _height = window.size.height;

    _orientation = window.orientation;

    _statusBarHeight = window.padding.top;
    _bottomBarHeight = window.padding.bottom;

    _scaleWidth = _width / (uiSize?.width ?? _width);
    _scaleHeight = _height / (uiSize?.height ?? _height);

    _textScaleFactor = _scaleWidth;
  }

  late final double _devicePixelRatio;
  late final double _textScaleFactor;

  late final double _width;
  late final double _height;
  late final Orientation _orientation;

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

  /// 屏幕方向
  Orientation get orientation => _orientation;

  /// 是否横屏模式
  bool get isLandscape => _orientation == Orientation.landscape;

  /// 是否竖屏模式
  bool get isPortrait => _orientation == Orientation.portrait;
}

extension ScreenExt on YuroInterface {
  static Screen? _instance;

  /// 获取屏幕信息
  Screen get screen => _instance ??= Screen._();

  /// 修改设计图尺寸
  void changeUiSize(Size? size) => Screen.uiSize = size;
}

extension ScreenNumExt on num {
  double get w => Yuro.screen.setWidth(this);

  double get h => Yuro.screen.setHeight(this);

  double get sw => Yuro.screen.width * this;

  double get sh => Yuro.screen.height * this;

  double get sp => Yuro.screen.textScaleFactor * this;
}
