import 'dart:math';
import 'dart:typed_data';

import 'package:buffer/buffer.dart';
import 'package:yuro/util/util.dart';

// FIN，指明Frame是否是一个Message里最后Frame（之前说过一个Message可能又多个Frame组成）；1bit，是否为信息的最后一帧
// RSV1-3，默认是0 (必须是0)，除非有扩展定义了非零值的意义。
// Opcode，这个比较重要，有如下取值是被协议定义的
// 				0x00 附加数据帧
// 				0x01 表示一个text frame
// 				0x02 表示一个binary frame
// 				0x03 ~~ 0x07暂时无定义，为以后的非控制帧保留
// 				0x08 表示连接关闭
// 				0x09 表示 ping (心跳检测相关)
// 				0x0a 表示 pong (心跳检测相关)
// 				0x0b ~~ 0x0f are reserved for further control frames,为将来的控制消息片段保留的操作码
// Mask，这个是指明“payload data”是否被计算掩码。这个和后面的Masking-key有关，如果设置为1,掩码键必须放在masking-key区域，客户端发送给服务端的所有消息，此位的值都是1；
// Payload len，数据的长度，
// Masking-key，0或者4bit，只有当MASK设置为1时才有效。，给一个WebSocket中掩码的意义
// Payload data，帧真正要发送的数据，可以是任意长度，但尽管理论上帧的大小没有限制，但发送的数据不能太大，否则会导致无法高效利用网络带宽，正如上面所说WebSocket提供分片。
// Extension data：扩展数据，如果客户端和服务端没有特殊的约定，那么扩展数据长度始终为0
// Application data：应用数据，

enum SocketOpcode {
  ping(0x9, 'ping'),
  pong(0xa, 'pong'),
  connect(0x3, 'connect'),
  connectOk(0x4, 'connectOk'),
  text(0x1, 'text'),
  binary(0x2, 'binary'),
  disconnect(0x8, 'disconnect'),
  unknown(0xf, 'unknown');

  final int code;
  final String desc;

  const SocketOpcode(this.code, this.desc);

  factory SocketOpcode.fromCode(int code) {
    return SocketOpcode.values.firstWhere((e) => e.code == code, orElse: () => SocketOpcode.unknown);
  }
}

class SocketEvent {
  final SocketOpcode opcode;
  final List<int> payload;
  final bool fromServer;

  SocketEvent._(this.opcode, {this.payload = const [], required this.fromServer});

  /// ping
  /// * [fromServer] 是否来自服务端
  factory SocketEvent.ping(bool fromServer) => SocketEvent._(SocketOpcode.ping, fromServer: fromServer);

  /// pong
  /// * [fromServer] 是否来自服务端, 默认false
  factory SocketEvent.pong(bool fromServer) => SocketEvent._(SocketOpcode.pong, fromServer: fromServer);

  /// 服务端收到连接请求后, 返回0x3的确认代码, 并告知客户端心跳间隔和超时时间
  /// * [pingInterval] ping发送间隔, 单位秒 ,范围0-65535
  /// * [pingTimeout] ping接收超时, 单位秒 ,范围0-65535
  factory SocketEvent.connect([int pingInterval = 0, int pingTimeout = 0]) {
    assert(pingInterval >= 0 && pingInterval <= 65535);
    assert(pingTimeout >= 0 && pingTimeout <= 65535);
    final contentWriter = ByteDataWriter();
    contentWriter.writeUint16(min(pingInterval, 65535));
    contentWriter.writeUint16(min(pingInterval, 65535));
    return SocketEvent._(SocketOpcode.connect, payload: contentWriter.toBytes(), fromServer: true);
  }

  /// 客户端收到服务端的0x3代码后,返回0x4, 确认收到服务端的心跳约定, 服务端收到后开始心跳检测
  factory SocketEvent.connectOk() => SocketEvent._(SocketOpcode.connectOk, fromServer: false);

  /// 发送文本数据
  /// * [fromServer] 是否来自服务端
  /// * [payload] 发送的内容
  factory SocketEvent.text(bool fromServer, String content) {
    return SocketEvent._(SocketOpcode.text, payload: content.toBytes(), fromServer: fromServer);
  }

  /// 发送二进制数据
  /// * [fromServer] 是否来自服务端
  /// * [payload] 发送的内容
  factory SocketEvent.binary(bool fromServer, List<int> contents) {
    return SocketEvent._(SocketOpcode.binary, payload: contents, fromServer: fromServer);
  }

  /// 连接关闭
  /// * [fromServer] 是否来自服务端, 默认false
  /// * [reason] 关闭原因
  factory SocketEvent.disconnect({bool fromServer = false, String? reason}) {
    return SocketEvent._(SocketOpcode.disconnect, payload: reason?.toBytes() ?? [], fromServer: fromServer);
  }

  ///
  factory SocketEvent.fromBytes(List<int> bytes) {
    final contentReader = ByteDataReader();
    contentReader.add(bytes);

    // opcode
    final opcodeStr = contentReader.readUint8().toRadixString(2).substring(4);
    final opcode = int.parse(opcodeStr, radix: 2);

    // mask 1->来自客户端, 0->来自服务端
    var binary = contentReader.readUint8().toRadixString(2).padLeft(8, '0');
    bool mask = binary.substring(0, 1) == '1';
    int length = int.parse(binary.substring(1), radix: 2);

    List<int> _payload(bool mask) {
      if (!mask) return contentReader.read(length);
      // masking-key
      final value = contentReader.readUint32();
      final maskingKey = [value >> 24, (value & 0x00FF0000) >> 16, (value & 0x0000FF00) >> 8, value & 0x000000FF];
      final contents = contentReader.read(length).mapIndexed((i, e) => e ^ maskingKey[i % 4]).toList();
      return contents;
    }

    // payload
    List<int> payload = [];
    if (length <= 125) {
      payload.addAll(_payload(mask));
    } else if (length == 126) {
      contentReader.readInt16();
      payload.addAll(_payload(mask));
    } else if (length == 127) {
      contentReader.readInt64();
      payload.addAll(_payload(mask));
    }
    return SocketEvent._(SocketOpcode.fromCode(opcode), fromServer: !mask, payload: payload);
  }

  Map<String, dynamic> toJson() => {'opcode': opcode, 'fromServer': fromServer, 'payload': payload};
}

extension SocketEventExt on SocketEvent {
  int get length => payload.length;

  /// 将事件转为待发送的数据
  Uint8List toBytes() {
    final contentWriter = ByteDataWriter();
    final sb = StringBuffer();
    // fin 指明Frame是否是一个Message里最后Frame, 1bit
    // RSV1-RSV3 3bit 都是0
    // opcode 4bit
    sb
      ..write(1)
      ..write('000')
      ..write(opcode.code.toRadixString(2).padLeft(4, '0'));
    contentWriter.writeUint8(int.parse(sb.toString(), radix: 2));

    sb.clear();
    // mask 1bit
    sb.write(fromServer ? 0 : 1);
    // content length 7bit
    final length = payload.length;
    // 如果length值在0-125，则是payload的真实长度
    if (length <= 125) {
      sb.write(length.toRadixString(2).padLeft(7, '0'));
      contentWriter.writeUint8(int.parse(sb.toString(), radix: 2));
    }
    // 如果length值是126，则后面2个字节形成的16位无符号整型数的值是payload的真实长度。
    else if (length <= 65535) {
      sb.write(126.toRadixString(2).padLeft(7, '0'));
      contentWriter.writeUint8(int.parse(sb.toString(), radix: 2));
      contentWriter.writeUint16(length);
    }
    // 如果length值是127，则后面8个字节形成的64位无符号整型数的值是payload的真实长度
    else {
      sb.write(127.toRadixString(2).padLeft(7, '0'));
      contentWriter.writeUint8(int.parse(sb.toString(), radix: 2));
      contentWriter.writeUint64(length);
    }
    // masking-key
    final maskingKey = List.generate(4, (index) => Random().nextInt(255));
    if (!fromServer) {
      final binary = maskingKey.map((e) => e.toRadixString(2).padLeft(8, '0')).join();
      contentWriter.writeUint32(int.parse(binary, radix: 2));
    }
    // payload data
    if (payload.isNotEmpty) {
      var content = payload;
      if (!fromServer) content = payload.mapIndexed((i, e) => e ^ maskingKey[i % 4]).toList();
      contentWriter.write(content);
    }
    return contentWriter.toBytes();
  }
}
