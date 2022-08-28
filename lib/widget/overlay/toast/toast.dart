import 'package:flutter/material.dart';
import 'package:yuro/core/core.dart';

part 'toast_container.dart';
part 'toast_manager.dart';
part 'toast_theme.dart';

extension YuroToastExt on YuroInterface {
  static final ToastManager _toast = ToastManager();

  ToastManager get toast => _toast;
}
