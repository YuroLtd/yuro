import 'package:collection/collection.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart' hide ValueNotifier;
import 'package:yuro/core/core.dart';

import 'listenable/listen_notifier.dart';
import 'listenable/value_notifier.dart';

mixin _ObserverComponent on ComponentElement {
  List<Disposer>? disposers = [];

  void _safeRebuild() async {
    if (disposers == null || dirty) return;
    final instance = SchedulerBinding.instance;
    if (instance.schedulerPhase != SchedulerPhase.idle) {
      await instance.endOfFrame;
      if (dirty) return;
    }
    markNeedsBuild();
  }

  @override
  Widget build() => Notifier.instance.append(NotifyData(disposers!, _safeRebuild), super.build);

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
  const _ObsWidget({Key? key}) : super(key: key);

  @override
  StatelessElement createElement() => _ObsElement(this);
}

class Obs extends _ObsWidget {
  final Widget Function(Widget? child) builder;
  final Widget? child;

  const Obs(this.builder, {Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) => builder.call(child);
}

class ObsValue<T> extends _ObsWidget {
  final ValueNotifier<T> notifier;
  final Widget Function(T value, Widget? child) builder;
  final Widget? child;

  const ObsValue({Key? key, required this.notifier, required this.builder, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) => builder.call(notifier.value, child);
}
