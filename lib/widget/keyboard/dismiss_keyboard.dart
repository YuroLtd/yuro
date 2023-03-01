import 'package:flutter/widgets.dart';

/// 点击空白处隐藏软键盘
class DismissKeyBoard extends StatelessWidget {
  final Widget? child;

  const DismissKeyBoard({super.key, this.child});

  @override
  Widget build(BuildContext context) => GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: child,
      );
}
