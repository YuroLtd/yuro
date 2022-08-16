import 'dart:io';

import 'package:yuro/core/core.dart';
import 'package:yuro/logger/logger.dart';
import 'package:yuro/state/state.dart';

import 'socket_client.dart';

abstract class SocketServer extends YuroService {
  final _connectionPool = <String, SocketClient>{};
  final _logger = Yuro.tag('SocketServer');
  ServerSocket? _serverSocket;

  /// 启动Socket服务器
  void start(String address, {int port = 0, int pingInterval = 10, int pingTimeout = 10}) async {
    assert(pingInterval >= 0 && pingInterval <= 65535);
    assert(pingTimeout >= 0 && pingTimeout <= 65535);
    // 启动前,如果之前有启动过则先关闭
    await _serverSocket?.close();
    ServerSocket.bind(address, port).then((server) {
      _logger.i('server on [${server.address.host}:${server.port}] started.');
      _logger.i('listening for connections.');
      server.listen((socket) {
        final host = socket.remoteAddress.address;
        final port = socket.remotePort;
        final identityId = '$host:$port';
        _connectionPool[identityId] = SocketClient(identityId, socket, pingInterval, pingTimeout);
        _logger.i('[$identityId] connected.');
      });
      _serverSocket = server;
    }).catchError((err) {
      _logger.e('server on [$address:$port] startup failed. $err');
    });
  }

  void close() async {
    for (final element in _connectionPool.values) {
       element.close();
    }
    await _serverSocket?.close();
    _serverSocket = null;
    _logger.i('server closed.');
  }
}
