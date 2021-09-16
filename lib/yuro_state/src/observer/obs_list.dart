import 'package:flutter/material.dart';

import '../notifier/list_notifier.dart';

typedef ListWidgetBuilder<T> = Widget Function(BuildContext context, List<T> list, Widget? child);

class ObsList<T> extends StatefulWidget {
  const ObsList({Key? key, required this.listListenable, required this.builder, this.child}) : super(key: key);

  final ListNotifier<T> listListenable;
  final ListWidgetBuilder<T> builder;
  final Widget? child;

  @override
  _ObsListState<T> createState() => _ObsListState<T>();
}

class _ObsListState<T> extends State<ObsList<T>> {
  late List<T> list;

  void _listUpdate() => setState(() => list = widget.listListenable.value);

  @override
  void initState() {
    super.initState();
    list = widget.listListenable.value;
    widget.listListenable.addListener(_listUpdate);
  }

  @override
  void didUpdateWidget(covariant ObsList<T> oldWidget) {
    if (oldWidget.listListenable != widget.listListenable) {
      oldWidget.listListenable.removeListener(_listUpdate);
      list = widget.listListenable.value;
      widget.listListenable.addListener(_listUpdate);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    widget.listListenable.removeListener(_listUpdate);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, list, widget.child);
}
