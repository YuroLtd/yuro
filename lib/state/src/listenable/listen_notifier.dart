import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:yuro/core/core.dart';

abstract class ListenNotifier extends Listenable with ListenableMixin {}

mixin ListenableMixin on Listenable {
  final _listeners = <VoidCallback>[];

  @override
  void addListener(VoidCallback listener) => _listeners.add(listener);

  @override
  void removeListener(VoidCallback listener) => _listeners.remove(listener);

  bool containsListener(VoidCallback listener) => _listeners.contains(listener);

  @protected
  void reportRead() => Notifier.instance.read(this);

  @protected
  void refresh() => _listeners.forEachIndexed((index, element) => element.call());
}

class Notifier {
  static Notifier? _notifier;

  static Notifier get instance => _notifier ??= Notifier._();

  Notifier._();

  NotifyData? _notifyData;

  void read(ListenableMixin updater) {
    final listener = _notifyData?.updater;
    if (listener != null && !updater.containsListener(listener)) {
      updater.addListener(listener);
      _notifyData?.disposers.add(() => updater.removeListener(listener));
    }
  }

  T append<T>(NotifyData data, T Function() builder) {
    _notifyData = data;
    final result = builder.call();
    if (data.disposers.isEmpty) throw const ObsError();
    _notifyData = null;
    return result;
  }
}

class NotifyData {
  final List<Disposer> disposers;
  final VoidCallback updater;

  NotifyData(this.disposers, this.updater);
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
