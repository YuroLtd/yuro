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

/// 软键盘弹出与关闭监听
class KeyboardListener extends StatefulWidget {
  final void Function(bool open) onChanged;
  final Widget child;

  const KeyboardListener({required this.onChanged, required this.child, Key? key}) : super(key: key);

  @override
  _KeyboardListenerState createState() => _KeyboardListenerState();
}

class _KeyboardListenerState extends State<KeyboardListener> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);
    super.initState();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    widget.onChanged(MediaQuery.of(context).viewInsets.bottom != 0);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

class KeyboardSafeArea extends StatelessWidget {
  final Widget child;

  const KeyboardSafeArea({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: child,
      );
}
