// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:io';
import 'dart:typed_data';


import 'package:yuro/core/interface.dart';
import 'package:yuro/core/logging.dart';

import 'frame.dart';

mixin SocketClient {
  late InternetAddress address;
  late int port;
  Duration? timeout;

  Socket? _socket;
  StreamSubscription? _subscription;

  Future<void> connect(InternetAddress address, int port, [Duration? timeout]) async {
    this.address = address;
    this.port = port;
    this.timeout = timeout;
    await _closeConnection();
    final socket = await Socket.connect(address, port, timeout: timeout);
    _subscription = socket.listen(_onData);
    _socket = socket;
  }

  Future<void> close([String? reason]) async {
    try {
      add(SocketFrame.disconnect(reason));
    } finally {
      await _closeConnection();
    }
  }

  Future<void> _closeConnection() async {
    try {
      await _subscription?.cancel();
      await _socket?.close();
    } finally {
      _socket = null;
    }
  }

  void _onData(Uint8List data) async {
    final frame = SocketFrame.fromBytes(data);
    switch (frame.opcode) {
      case SocketOpcode.connect:
        Yuro.tag('SocketClient').info('connected to [${_socket?.remoteAp}], .');
        connected();
        break;
      case SocketOpcode.ping:
        add(SocketFrame.pong());
        break;
      case SocketOpcode.pong:
        break;
      case SocketOpcode.text:
        print('[${_socket?.remoteAp}]: ${frame.toString()}');
        onText(String.fromCharCodes(frame.payload));
        break;
      case SocketOpcode.binary:
        print('[${_socket?.remoteAp}]: ${frame.toString()}');
        onBinary(frame.payload);
        break;
      case SocketOpcode.disconnect:
        await _closeConnection();
        disconnected();
        break;
      case SocketOpcode.invalid:
        break;
      case SocketOpcode.unknown:
        Yuro.tag('SocketClient').warning('unknown opcode(${frame.opcode})');
        break;
    }
  }

  /// 发送数据
  bool add(SocketFrame frame) {
    try {
      _socket?.add(frame.toBytes(false));
      return true;
    } catch (e) {
      Yuro.tag('SocketClient').severe('send data failed. $e');
      return false;
    }
  }

  void connected() {}

  void disconnected() {
    Yuro.tag('SocketClient').info('server has disconnected.');
  }

  // 收到文本
  void onText(String text) {}

  // 收到二进制
  void onBinary(List<int> data) {}
}
