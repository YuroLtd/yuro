import 'dart:async';

import 'package:yuro/core/interface.dart';
import 'package:yuro/state/lifecycle.dart';
import 'package:yuro/utils/event_bus.dart';

mixin EventMixin on YuroLifeCycle {
  late final StreamSubscription _subscription;

  List<int> get events;

  @override
  void onInit() async {
    _subscription = Yuro.stream<Event>().where((event) => events.contains(event.code)).listen(handlerEvent);
    super.onInit();
  }

  void handlerEvent(Event event);

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
