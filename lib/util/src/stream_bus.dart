import 'dart:async';

import 'package:yuro/core/core.dart';

extension StreamBusExt on YuroInterface {
  static final StreamController _streamController = StreamController.broadcast();

  Stream<T> streamOn<T>() => _streamController.stream.where((event) => event is T).cast<T>();

  Stream<StreamEvent> streamEventOn([List<int> codes = const []]) =>
      streamOn<StreamEvent>().where((event) => codes.isNotEmpty ? codes.contains(event.code) : true);

  void fire(dynamic event) => _streamController.add(event);
}

class StreamEvent {
  final int code;
  final String? msg;
  final dynamic extra;

  StreamEvent(this.code, {this.msg, this.extra});

  void post() => Yuro.fire(this);
}
