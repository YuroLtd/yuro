import 'dart:async';

import 'package:yuro/yuro_core/yuro_core.dart';

extension StreamBusExt on YuroInterface {
  static final StreamController _streamController = StreamController.broadcast();

  Stream<T> streamOn<T>() => _streamController.stream.where((event) => event is T).cast<T>();

  void sendStream(dynamic event) => _streamController.add(event);

  Stream<StreamEvent> streamEventOn([List<int> codes = const []]) => _streamController.stream
      .where((event) => event is StreamEvent)
      .cast<StreamEvent>()
      .where((event) => codes.isNotEmpty ? codes.contains(event.code) : true);
}

class StreamEvent {
  final int code;
  final String? msg;
  final dynamic extra;

  StreamEvent(this.code, {this.msg, this.extra});
}

extension StreamEventExt on StreamEvent {
  void post() => Yuro.sendStream(this);
}
