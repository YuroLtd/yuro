import 'dart:async';

import 'package:yuro/yuro_core/yuro_core.dart';

extension StreamBusExt on YuroInterface {
  static final StreamController _streamController = StreamController.broadcast();

  Stream<T> streamOn<T>() => _streamController.stream.where((event) => event is T).cast<T>();

  void postEvent(dynamic event) => _streamController.add(event);

  void post(int code, [String? msg, dynamic extra]) => _streamController.add(StreamEvent(code, msg: msg, extra: extra));

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

  void post() => Yuro.postEvent(this);
}
