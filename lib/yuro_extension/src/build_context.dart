import 'package:flutter/material.dart';

/// Desc: FocusScope相关
extension FocusScopeExt on BuildContext {
  void unFocus({UnfocusDisposition disposition = UnfocusDisposition.scope}) {
    FocusScope.of(this).unfocus(disposition: disposition);
  }

  void requestFocus([FocusNode? focusNode]) {
    FocusScope.of(this).requestFocus(focusNode);
  }
}
