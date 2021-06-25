import 'dart:async';

import 'package:yuro/yuro_core/yuro_core.dart';

extension StreamBusExt on YuroInterface {
  static StreamController _streamController = StreamController.broadcast();

  Stream<T> streamOn<T>() => _streamController.stream.where((event) => event is T).cast<T>();

  void sendStream(dynamic event) => _streamController.add(event);
}

class StreamEvent {
  final int code;
  final String? msg;
  final Map<String, dynamic>? extra;

  StreamEvent(this.code, {this.msg, this.extra});
}

extension StreamEventExt on StreamEvent {
  void post() => Yuro.sendStream(this);
}
