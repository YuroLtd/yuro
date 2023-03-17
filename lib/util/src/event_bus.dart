import 'dart:async';

import 'package:yuro/core/core.dart';
import 'package:yuro/util/util.dart';

extension EventBusExt on YuroInterface {
  Stream<T> stream<T>() => Yuro.eventBus.stream.where((event) => event is T).cast<T>();

  Stream<Event> streamOn(int code, [int? code1, int? code2, int? code3, int? code4, int? code5]) {
    final codes = [code, code1, code2, code3, code4, code5].whereNotNull();
    return stream<Event>().where((event) => codes.contains(event.code));
  }

  void fire(dynamic event) => Yuro.eventBus.add(event);
}

class Event {
  final int code;
  final dynamic extra;

  Event(this.code, [this.extra]);

  void fire() => Yuro.fire(this);
}
