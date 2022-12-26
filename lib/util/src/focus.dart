import 'package:flutter/material.dart';
import 'package:yuro/core/core.dart';

extension YuroFocusExt on YuroInterface {
  void unFocus({UnfocusDisposition disposition = UnfocusDisposition.scope}) {
    FocusManager.instance.primaryFocus?.unfocus(disposition: disposition);
  }
}
