import 'package:flutter/widgets.dart';

/// 软键盘弹出与关闭监听
class KeyboardListener extends StatefulWidget {
  final void Function(bool open) onChanged;
  final Widget child;

  const KeyboardListener({required this.onChanged, required this.child, super. key});

  @override
  KeyboardListenerState createState() => KeyboardListenerState();
}

class KeyboardListenerState extends State<KeyboardListener> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    widget.onChanged(MediaQuery.of(context).viewInsets.bottom != 0);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
