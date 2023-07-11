import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:yuro/core/interface.dart';

class Screen {
  Screen(Size? uiSize) {
    final window = MediaQueryData.fromView(WidgetsBinding.instance.platformDispatcher.implicitView!);

    _devicePixelRatio = window.devicePixelRatio;

    _width = window.size.width;
    _height = window.size.height;

    _orientation = window.orientation;
    _brightness = window.platformBrightness;

    _statusBarHeight = window.viewInsets.top;
    _bottomBarHeight = window.viewInsets.bottom;

    if (uiSize != null) {
      // 如果设计图屏幕方向与实际方向不一致,交换设计尺寸的宽高值
      final uiOrientation = uiSize.width > uiSize.height ? Orientation.landscape : Orientation.portrait;
      if (_orientation != uiOrientation) uiSize = Size(uiSize.height, uiSize.width);
    }

    _scaleWidth = _width / (uiSize?.width ?? _width);
    _scaleHeight = _height / (uiSize?.height ?? _height);

    _textScaleFactor = _scaleWidth;
  }

  late final double _devicePixelRatio;
  late final double _textScaleFactor;

  late final double _width;
  late final double _height;

  late final Orientation _orientation;
  late final Brightness _brightness;

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

  /// 亮暗主题
  Brightness get brightness => _brightness;

  /// 是否横屏模式
  bool get isLandscape => _orientation == Orientation.landscape;

  /// 是否竖屏模式
  bool get isPortrait => _orientation == Orientation.portrait;
}

extension ScreenNumExt on num {
  double get w => Yuro.screen.setWidth(this);

  double get h => Yuro.screen.setHeight(this);

  double get sw => Yuro.screen.width * this;

  double get sh => Yuro.screen.height * this;

  double get sp => Yuro.screen.textScaleFactor * this;
}
