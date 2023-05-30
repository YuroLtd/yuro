import 'dart:async';

import 'package:yuro/core/interface.dart';
import 'package:yuro/state/lifecycle.dart';

mixin StreamMixin<T> on YuroLifeCycle {
  late final StreamSubscription _subscription;

  List<int> get events;

  @override
  Future<void> onInit() async {
    super.onInit();
    _subscription = Yuro.broadcast.stream.where((event) => event is T).cast<T>().listen(handlerEvent);
  }

  void handlerEvent(T event);

  @override
  void dispose() {
    super.dispose();
    _subscription.cancel();
  }
}
