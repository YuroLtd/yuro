
import 'package:flutter/widgets.dart';

class KeyboardSafeArea extends StatelessWidget {
  final Widget child;

  const KeyboardSafeArea({super. key, required this.child}) ;

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: child,
      );
}
