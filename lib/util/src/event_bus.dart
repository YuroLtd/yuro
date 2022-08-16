import 'dart:async';

import 'package:yuro/core/core.dart';

extension EventBusExt on YuroInterface {
  Stream<T> listenOn<T>() => Yuro.eventBus.stream.where((event) => event is T).cast<T>();

  Stream<Event> listenOnEvent([List<int> codes = const []]) =>
      listenOn<Event>().where((event) => codes.isNotEmpty ? codes.contains(event.code) : true);

  void post(dynamic event) => Yuro.eventBus.add(event);

  void postEvent(int code, [dynamic extra]) => Yuro.eventBus.add(Event(code, extra));
}

class Event {
  final int code;
  final dynamic extra;

  Event(this.code, [this.extra]);

  void post() => Yuro.post(this);
}
