import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:yuro/core/typedefs.dart';

mixin ValueNotifierMixin<T> on ValueNotifier<T> {
  final _listener = <VoidCallback>[];

  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);
    _listener.add(listener);
  }

  @override
  void removeListener(VoidCallback listener) {
    super.removeListener(listener);
    _listener.remove(listener);
  }

  bool _contains(VoidCallback listener) => _listener.contains(listener);

  void _reportRead() => _Notifier.instance.read(this);

  @override
  T get value {
    _reportRead();
    return super.value;
  }

  @override
  void notifyListeners() {
    super.notifyListeners();
    _listener.forEachIndexed((index, element) => element.call());
  }
}

class _Notifier {
  static _Notifier? _notifier;

  static _Notifier get instance => _notifier ??= _Notifier._();

  _Notifier._();

  _NotifyData? _notifyData;

  void read(ValueNotifierMixin updater) {
    final listener = _notifyData?.updater;
    if (listener != null && !updater._contains(listener)) {
      updater.addListener(listener);
      _notifyData?.disposers.add(() => updater.removeListener(listener));
    }
  }

  Widget append(_NotifyData data, Widget Function() builder) {
    _notifyData = data;
    final result = builder.call();
    if (data.disposers.isEmpty) throw const ObsError();
    _notifyData = null;
    return result;
  }
}

class _NotifyData {
  final List<Disposer> disposers;
  final VoidCallback updater;

  _NotifyData(this.disposers, this.updater);
}

class ObsError {
  const ObsError();

  @override
  String toString() => '''
  Improper use of [Obs] or [ObsValue] detected.
  You should only use [Obs] or [ObsValue] for the specific widget that will be updated.
  If you see this error, you may not have used observable variables in [Obs] or [ObsValue].
  ''';
}

mixin _ObserverComponent on ComponentElement {
  List<Disposer>? disposers = [];

  void getUpdate() {
    if (disposers != null) scheduleMicrotask(markNeedsBuild);
  }

  @override
  Widget build() => _Notifier.instance.append(_NotifyData(disposers!, getUpdate), super.build);

  @override
  void unmount() {
    super.unmount();
    disposers!.forEachIndexed((index, disposer) => disposer.call());
    disposers!.clear();
    disposers = null;
  }
}

class _ObsElement = StatelessElement with _ObserverComponent;

abstract class _ObsWidget extends StatelessWidget {
  const _ObsWidget({super.key});

  @override
  StatelessElement createElement() => _ObsElement(this);
}

class Obs extends _ObsWidget {
  final Widget Function(Widget? child) builder;
  final Widget? child;

  const Obs(this.builder, {super.key, this.child});

  @override
  Widget build(BuildContext context) => builder.call(child);
}

class ObsValue<T> extends _ObsWidget {
  final ValueNotifier<T> notifier;
  final Widget Function(T value, Widget? child) builder;
  final Widget? child;

  const ObsValue({super.key, required this.notifier, required this.builder, this.child});

  @override
  Widget build(BuildContext context) => builder.call(notifier.value, child);
}

class ObsValue2<T, R> extends _ObsWidget {
  final ValueNotifier<T> notifier1;
  final ValueNotifier<R> notifier2;
  final Widget Function(T value1, R value2, Widget? child) builder;
  final Widget? child;

  const ObsValue2({super.key, required this.notifier1, required this.notifier2, required this.builder, this.child});

  @override
  Widget build(BuildContext context) => builder.call(notifier1.value, notifier2.value, child);
}
