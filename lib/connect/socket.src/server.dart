import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:yuro/core/core.dart';

import 'frame.dart';

mixin SocketServer {
  final _socketPool = <int, Socket>{};
  final _subscriptionPool = <int, StreamSubscription>{};
  final _pongPool = <int, Timer>{};

  ServerSocket? _server;
  Duration _pingInterval = Duration.zero;
  Duration _pongTimeout = Duration.zero;

  Timer? _pingTimer;

  int get socketSize => _socketPool.length;

  Socket? getSocket(int identityId) => _socketPool[identityId];

  Future<void> startServer(
    InternetAddress address,
    int port, {
    Duration pingInterval = const Duration(seconds: 30),
    Duration pongTimeout = const Duration(seconds: 20),
  }) async {
    assert(pingInterval.inSeconds <= 255);
    assert(pongTimeout.inSeconds <= 255);

    await closeServer();
    final server = await ServerSocket.bind(address, port);
    server.listen(_handlerConnection);
    _pingInterval = pingInterval;
    _pongTimeout = pongTimeout;
    _server = server;
    _startHeart();
    Yuro.tag('SocketServer').i('socket server on [${server.ap}] started, listen for connections.');
  }

  void _handlerConnection(Socket socket) async {
    // 先关闭旧连接
    await _closeConnection(socket.identityId);
    _socketPool[socket.identityId] = socket;
    _subscriptionPool[socket.identityId] = socket.listen((data) => _onData(socket, data));
    Yuro.tag('SocketServer').i('[${socket.remoteAp}] connect.');
    add(socket, SocketFrame.connect([_pingInterval.inSeconds, _pongTimeout.inSeconds]));
    connected(socket.identityId);
  }

  Future<void> closeServer() async {
    if (_server == null) return;
    Yuro.tag('SocketServer').i('socket server closing.');
    _pingTimer?.cancel();
    _socketPool.values.forEachIndexed((index, socket) {
      add(socket, SocketFrame.disconnect('server closed'));
      Yuro.tag('SocketServer').i('close connection. [${index + 1}/$socketSize]');
      _closeConnection(socket.identityId);
    });
    await _server!.close();
    Yuro.tag('SocketServer').i('socket server closed.');
  }

  Future<void> _closeConnection(int identityId) async {
    // 取消pong计时
    _pongPool.remove(identityId)?.cancel();
    // 移除接收
    await _subscriptionPool.remove(identityId)?.cancel();

    // 关闭发送
    final socket = _socketPool.remove(identityId);
    await socket?.flush();
    await socket?.close();

    // 业务上处理连接关闭
    await disconnected(identityId);
  }

  void _onData(Socket socket, Uint8List data) {
    final frame = SocketFrame.fromBytes(data);
    switch (frame.opcode) {
      case SocketOpcode.connect:
        // do nothing
        break;
      case SocketOpcode.ping:
        add(socket, SocketFrame.pong());
        break;
      case SocketOpcode.pong:
        _pongPool.remove(socket.identityId)?.cancel();
        break;
      case SocketOpcode.text:
        Yuro.tag('SocketServer').i('[${socket.remoteAp}]: ${frame.toString()}');
        onText(socket.identityId, String.fromCharCodes(frame.payload));
        break;
      case SocketOpcode.binary:
        Yuro.tag('SocketServer').i('[${socket.remoteAp}]: ${frame.toString()}');
        onBinary(socket.identityId, frame.payload);
        break;
      case SocketOpcode.disconnect:
        Yuro.tag('SocketServer').i('[${socket.remoteAp}] disconnect.');
        _closeConnection(socket.identityId);
        break;
      case SocketOpcode.invalid:
        break;
      case SocketOpcode.unknown:
        Yuro.tag('SocketServer').w('${socket.identityId} unknown opcode(${frame.opcode})');
        break;
    }
  }

  /// 向[target]Socket发送数据
  bool add(Socket target, SocketFrame frame) {
    try {
      target.add(frame.toBytes());
      return true;
    } catch (e) {
      Yuro.tag('SocketServer').e('[${target.identityId}] $e');
      return false;
    }
  }

  /// 向标识为[identityId]的Socket发送数据
  bool addBy(int identityId, SocketFrame frame) {
    final target = getSocket(identityId);
    if (target == null) {
      Yuro.tag('SocketServer').w('target [$identityId] not exist.');
      return false;
    } else {
      return add(target, frame);
    }
  }

  void _startHeart() {
    if (_pingInterval == Duration.zero || _pongTimeout == Duration.zero) return;
    pingFunc(Socket socket) {
      final ap = socket.remoteAp;
      final identityId = socket.identityId;
      if (add(socket, SocketFrame.ping())) {
        _pongPool[identityId] = Timer(_pongTimeout, () {
          Yuro.tag('SocketServer').w('[$ap] pong timeout, close connection.');
          _closeConnection(identityId);
        });
      }
    }

    _pingTimer = Timer.periodic(_pingInterval, (timer) {
      _socketPool.values.forEach(pingFunc);
    });
  }

  // 收到文本
  void onText(int identityId, String text) {}

  // 收到二进制
  void onBinary(int identityId, List<int> data) {}

  // 设备连接
  void connected(int identityId) {}

  // 关闭连接
  Future<void> disconnected(int identityId) async {}
}
