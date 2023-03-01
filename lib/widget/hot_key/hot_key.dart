import 'package:flutter/widgets.dart';

@immutable
abstract class HotKey extends Intent {
  const HotKey();

  String get label;

  ShortcutActivator get shortcut;
}

class HotKeyAction<T extends Intent> extends Action<T> {
  HotKeyAction(this.onInvoke);

  @protected
  final OnInvokeCallback<T> onInvoke;

  @override
  Object? invoke(T intent) => onInvoke(intent);
}

class HotKeys extends StatelessWidget {
  final List<HotKey> hotKeys;
  final Map<Type, Action> hotKeyActions;
  final Widget child;

  const HotKeys({super.key, required this.hotKeys, required this.hotKeyActions, required this.child});

  Map<ShortcutActivator, Intent> get _shortcuts {
    final shortcuts = hotKeys.map((e) => MapEntry(e.shortcut, e)).toList();
    return Map.fromEntries(shortcuts);
  }

  @override
  Widget build(BuildContext context) => Shortcuts(
      shortcuts: _shortcuts,
      child: Actions(
        actions: hotKeyActions,
        child: FocusScope(autofocus: true, child: child),
      ));
}
