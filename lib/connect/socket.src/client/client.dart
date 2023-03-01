import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:buffer/buffer.dart';
import 'package:yuro/core/core.dart';
import 'package:yuro/state/state.dart';
import 'package:yuro/util/util.dart';

import '../events.dart';
import '../status.dart';

abstract class SocketClient extends YuroService {
  final _logger = Yuro.tag('SocketClient');

  late Socket _socket;
  SocketStatus _status = SocketStatus.not_connected;
  String? _closeReason;

  SocketStatus get status => _status;

  String? get closeReason => _closeReason;

  int get maxRetry => 3;
  int _retryCount = 0;

  int _pingInterval = 0;
  int _pingTimeout = 0;
  Timer? _pingTimer;
  Timer? _pongTimer;

  void connect(String host, int port, {Duration timeLimit = const Duration(seconds: 10)}) {
    if (_status == SocketStatus.connecting) {
      _logger.i('connecting...');
      return;
    }
    if (_status == SocketStatus.connected) {
      _logger.i('connected.');
      return;
    }
    if (_status != SocketStatus.connect_timeout) {
      _logger.i('start connecting to $host:$port');
    }
    _status = SocketStatus.connecting;
    Socket.connect(host, port).then((socket) {
      _retryCount = 0;
      socket.listen(_onData);
      _socket = socket;
    }).timeout(timeLimit, onTimeout: () {
      if (_retryCount < maxRetry) {
        _logger.i('connect timed out....retry ${++_retryCount}');
        _status = SocketStatus.connect_timeout;
        connect(host, port, timeLimit: timeLimit);
      } else {
        throw 'maximum number of attempts reached';
      }
    }).catchError((error) {
      _logger.i('connect failed: $error');
      _retryCount = 0;
      _status = SocketStatus.failed;
    });
  }

  void onConnected() {}

  void onText(String text) {}

  void onBinary(List<int> binaries) {}

  void disconnected() {}

  void sendText(String text) => _send(SocketEvent.text(false, text));

  void sendBinary(List<int> data) => _send(SocketEvent.binary(false, data));

  void close([String? reason]) {
    _logger.i('close connection.');
    _send(SocketEvent.disconnect(fromServer: false, reason: reason));
    _close(reason);
  }

  void _onData(Uint8List data) {
    final event = SocketEvent.fromBytes(data);
    switch (event.opcode) {
      case SocketOpcode.connect:
        final reader = ByteDataReader()..add(event.payload);
        _pingInterval = reader.readUint16();
        _pingTimeout = reader.readUint16();
        _send(SocketEvent.connectOk());
        _status = SocketStatus.connected;
        onConnected();
        break;
      case SocketOpcode.connectOk:
        //  do nothing
        break;
      case SocketOpcode.ping:
        _startPingTimer();
        _send(SocketEvent.pong(false));
        break;
      case SocketOpcode.pong:
        _pongTimer?.cancel();
        break;
      case SocketOpcode.text:
        onText(event.payload.toStr());
        break;
      case SocketOpcode.binary:
        onBinary(event.payload);
        break;
      case SocketOpcode.disconnect:
        _logger.i('server closed: ${event.payload.toStr()}');
        _close('server closed.');
        disconnected();
        break;
      case SocketOpcode.unknown:
        break;
    }
  }

  void _send(SocketEvent event) {
    if (status != SocketStatus.connected) {
      _logger.w('send data failed, socket status: ${status.name}');
      return;
    }
    try {
      _socket.add(event.toBytes());
    } on SocketException catch (e) {
      _close(e.message);
    }
  }

  void _startPingTimer() {
    _pingTimer?.cancel();
    // 如果_pingInterval==0,表示无需ping-pong
    if (_pingInterval == 0) return;
    _pingTimer = Timer(Duration(seconds: _pingInterval + _pingTimeout), () {
      _logger.w('receive ping timeout, send ping to server to confirm server status.');
      _send(SocketEvent.ping(false));
      _pongTimer = Timer(Duration(seconds: _pingInterval + _pingTimeout), () async {
        _logger.w('the pong from the server is not received, the connection is closed.');
        _closeReason = 'Server not responding';
        await _socket.close();
        _status = SocketStatus.closed;
      });
    });
  }

  void _close([String? reason]) {
    _pingTimer?.cancel();
    _pongTimer?.cancel();

    _closeReason = reason;
    _socket.destroy();
    _status = SocketStatus.closed;
    _logger.i('connection closed, reason: $reason.');
  }
}
