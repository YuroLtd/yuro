import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:yuro/core/core.dart';
import 'package:yuro/logger/logger.dart';
import 'package:yuro/util/src/convert.dart';

import '../events.dart';
import '../status.dart';

class SocketClient {
  final String identityId;
  final Socket socket;
  final int pingInterval;
  final int pingTimeout;

  final _logger = Yuro.tag('SocketServer');

  SocketStatus _status = SocketStatus.not_connected;

  SocketStatus get status => _status;

  Timer? _pingTimer;
  Timer? _pongTimer;

  SocketClient(this.identityId, this.socket, this.pingInterval, this.pingTimeout) {
    _status = SocketStatus.connecting;
    socket.listen(_onData);
    send(SocketEvent.connect(pingInterval, pingTimeout));
  }

  void send(SocketEvent event) {
    if (status != SocketStatus.connected) {
      _logger.w('send data failed, socket status: ${status.name}');
      return;
    }
    try {
      socket.add(event.toBytes());
    } on SocketException catch (_) {
      _close();
    }
  }

  void close() {
    send(SocketEvent.disconnect(fromServer: true, reason: 'goAway'));
    _close();
  }

  void onText(String text) {}

  void onBinary(List<int> binaries) {}

  void _onData(Uint8List data) {
    final event = SocketEvent.fromBytes(data);
    switch (event.opcode) {
      case SocketOpcode.connect:
        // do nothing
        break;
      case SocketOpcode.connectOk:
        _status = SocketStatus.connected;
        _startPingTimer();
        break;
      case SocketOpcode.ping:
        send(SocketEvent.pong(true));
        break;
      case SocketOpcode.pong:
        _pongTimer?.cancel();
        _startPingTimer();
        break;
      case SocketOpcode.text:
        onText(event.payload.toStr());
        break;
      case SocketOpcode.binary:
        onBinary(event.payload);
        break;
      case SocketOpcode.disconnect:
        _close();
        break;
      case SocketOpcode.unknown:
        _logger.w('[$identityId] unknown opcode');
        break;
    }
  }

  void _startPingTimer() {
    _pingTimer?.cancel();
    // 如果_pingInterval==0,表示无需ping-pong
    if (pingInterval == 0) return;
    _pingTimer = Timer(Duration(seconds: pingInterval), () {
      send(SocketEvent.ping(true));
      _pongTimer = Timer(Duration(seconds: pingInterval + pingTimeout), _close);
    });
  }

  void _close() {
    _pingTimer?.cancel();
    _pongTimer?.cancel();
    socket.destroy();
    _status = SocketStatus.closed;
    _logger.i('[$identityId] close connection.');
  }

  @override
  int get hashCode => identityId.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SocketClient && other.identityId == identityId;
  }
}
