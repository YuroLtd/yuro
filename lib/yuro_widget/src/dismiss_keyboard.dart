import 'package:flutter/material.dart';

/// 全局点击空白处隐藏软键盘
class DismissKeyBoard extends StatelessWidget {
  final Widget? child;

  const DismissKeyBoard({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: child,
      );
}
