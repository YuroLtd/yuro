import 'dart:async';

import 'package:yuro/core/core.dart';
import 'package:yuro/util/src/event_bus.dart';

import '../yuro_controller.dart';

mixin StreamMixin on YuroController {
  late final StreamSubscription _subscription;

  List<int> get events;

  @override
  void onInit() {
    super.onInit();
    _subscription = Yuro.stream<Event>().where((event) => events.contains(event.code)).listen(handlerEvent);
  }

  void handlerEvent(Event event);

  @override
  void onDispose() {
    _subscription.cancel();
    super.onDispose();
  }
}
