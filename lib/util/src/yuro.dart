import 'package:flutter/material.dart';
import 'package:yuro/core/core.dart';

extension YuroExt on YuroInterface {
  void unFocus({UnfocusDisposition disposition = UnfocusDisposition.scope}) {
    FocusManager.instance.primaryFocus?.unfocus(disposition: disposition);
  }
}
