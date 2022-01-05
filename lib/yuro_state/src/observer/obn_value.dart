import 'package:flutter/widgets.dart';

abstract class NValueListenable<T> extends Listenable {
  const NValueListenable();

  T? get value;
}

class NValueNotifier<T> extends ChangeNotifier implements NValueListenable<T> {
  NValueNotifier([this._value]);

  T? _value;

  @override
  T? get value => _value;

  set value(T? newValue) {
    if (_value == newValue) return;
    _value = newValue;
    notifyListeners();
  }
}

typedef NValueWidgetBuilder<T> = Widget Function(BuildContext context, T? value, Widget? child);

class Obn<T> extends StatefulWidget {
  const Obn({Key? key, required this.valueListenable, required this.builder, this.child}) : super(key: key);

  final NValueNotifier<T> valueListenable;

  final NValueWidgetBuilder<T> builder;

  final Widget? child;

  @override
  State<StatefulWidget> createState() => _ObnState<T>();
}

class _ObnState<T> extends State<Obn<T>> {
  late T? value;

  @override
  void initState() {
    super.initState();
    value = widget.valueListenable.value;
    widget.valueListenable.addListener(_valueChanged);
  }

  @override
  void didUpdateWidget(covariant Obn<T> oldWidget) {
    if (oldWidget.valueListenable != widget.valueListenable) {
      oldWidget.valueListenable.removeListener(_valueChanged);
      value = widget.valueListenable.value;
      widget.valueListenable.addListener(_valueChanged);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    widget.valueListenable.removeListener(_valueChanged);
    super.dispose();
  }

  void _valueChanged() => setState(() => value = widget.valueListenable.value);

  @override
  Widget build(BuildContext context) => widget.builder(context, value, widget.child);
}
