// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:io';

import 'package:yuro/core/interface.dart';
import 'package:yuro/core/logging.dart';

import 'frame.dart';

mixin UdpMixin {
  RawDatagramSocket? _udpSocket;
  StreamSubscription? _subscription;

  /// 启动udp广播
  Future<void> startUdp(InternetAddress address, int port) async {
    await closeUdp();
    final rawSocket = await RawDatagramSocket.bind(address, port);
    rawSocket.broadcastEnabled = true;
    _subscription = rawSocket.listen(_handlerEvent);
    _udpSocket = rawSocket;
    Yuro.tag('Udp').info('udp server on [${address.address}:$port] start success.');
  }

  void _handlerEvent(RawSocketEvent event) {
    final datagram = _udpSocket?.receive();
    if (datagram == null) return;
    Yuro.tag('Udp').info('[${datagram.ap}]: ${datagram.data.format()}');
    dispatchUdpEvent(datagram.address, datagram.port, datagram.data);
  }

  void dispatchUdpEvent(InternetAddress address, int port, List<int> data);

  /// 向指定IP地址及端口发送数据,
  /// 当返回-1时代表upd已关闭
  int send(List<int> buffer, InternetAddress address, int port) {
    print('${buffer.format()}->[${address.address}:$port]');
    return _udpSocket?.send(buffer, address, port) ?? -1;
  }

  int sendString(String content, InternetAddress address, int port) {
    return send(content.codeUnits, address, port);
  }

  /// 关闭udp广播
  Future<void> closeUdp() async {
    if (_udpSocket == null) return;
    Yuro.tag('Udp').info('udp server closing.');
    await _subscription?.cancel();
    _udpSocket?.close();
    _udpSocket = null;
    Yuro.tag('Udp').info('udp server closed.');
  }
}
