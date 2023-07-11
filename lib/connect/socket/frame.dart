import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:buffer/buffer.dart';
import 'package:collection/collection.dart';
import 'package:convert/convert.dart';
import 'package:crclib/catalog.dart';

extension SocketDatagramExt on Datagram {
  String get ap => '${address.address}:$port';
}

extension ServerSocketExt on ServerSocket {
  String get ap => '${address.address}:$port';
}

extension SocketExt on Socket {
  String get remoteAp => '${remoteAddress.address}:$remotePort';

  int get identityId => remoteAp.hashCode;
}

extension SocketListIntExt on List<int> {
  String format() => map((e) => e.toRadixString(16).padLeft(2, '0').toUpperCase()).join(' ');
}

//      0               1               2               3
//      0 1 2 3 4 5 6 7 0 1 2 3 4 5 6 7 0 1 2 3 4 5 6 7 0 1 2 3 4 5 6 7
//     +-+-+-+-+-------+-+-------------+-------------------------------+
//     |F|R|R|R| opcode|M| Payload len |    Extended payload length    |
//     |I|S|S|S|  (4)  |A|     (7)     |             (16/64)           |
//     |N|V|V|V|       |S|             |   (if payload len==126/127)   |
//     | |1|2|3|       |K|             |                               |
//     +-+-+-+-+-------+-+-------------+ - - - - - - - - - - - - - - - +
//     |     Extended payload length continued, if payload len == 127  |
//     + - - - - - - - - - - - - - - - +-------------------------------+
//     |                               |Masking-key, if MASK set to 1  |
//     +-------------------------------+-------------------------------+
//     | Masking-key (continued)       |          Payload Data         |
//     +-------------------------------- - - - - - - - - - - - - - - - +
//     :                     Payload Data continued ...                :
//     + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +
//     |                     Payload Data continued ...                |
//     +---------------------------------------------------------------+
//
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
  text(0x1, 'text'),
  binary(0x2, 'binary'),
  disconnect(0x8, 'disconnect'),
  invalid(0xe, 'payload is tampered'),
  unknown(0xf, 'unknown');

  final int code;
  final String desc;

  const SocketOpcode(this.code, this.desc);

  factory SocketOpcode.fromCode(int code) {
    return SocketOpcode.values.firstWhere((e) => e.code == code, orElse: () => SocketOpcode.unknown);
  }
}

class SocketFrame {
  final SocketOpcode opcode;
  final List<int> payload;

  SocketFrame._(this.opcode, {this.payload = const []});

  /// ping
  factory SocketFrame.ping() => SocketFrame._(SocketOpcode.ping);

  /// pong
  factory SocketFrame.pong() => SocketFrame._(SocketOpcode.pong);

  /// 服务端收到连接请求后, 返回0x3的确认代码
  factory SocketFrame.connect([List<int> bytes = const []]) => SocketFrame._(SocketOpcode.connect, payload: bytes);

  /// 发送文本数据
  factory SocketFrame.text(String content) => SocketFrame._(SocketOpcode.text, payload: utf8.encode(content));

  /// 发送二进制数据
  factory SocketFrame.binary(List<int> bytes) => SocketFrame._(SocketOpcode.binary, payload: bytes);

  /// 连接关闭
  /// * [reason] 关闭原因
  factory SocketFrame.disconnect([String? reason = 'goAlway']) =>
      SocketFrame._(SocketOpcode.disconnect, payload: utf8.encode(reason ?? ''));

  ///
  factory SocketFrame.fromBytes(List<int> bytes) {
    final contentReader = ByteDataReader();
    contentReader.add(bytes);

    // opcode
    final opcodeStr = contentReader.readUint8().toRadixString(2).substring(4);
    final opcode = int.parse(opcodeStr, radix: 2);

    // mask 1->来自客户端, 0->来自服务端
    final binary = contentReader.readUint8().toRadixString(2).padLeft(8, '0');
    final mask = binary.substring(0, 1) == '1';
    int length = int.parse(binary.substring(1), radix: 2);

    List<int> getPayload(bool mask) {
      if (mask) {
        final maskingKey = contentReader.readUint32();
        final binaryMaskingKey = hex.decode(maskingKey.toRadixString(16).padLeft(8, '0'));
        final payload = contentReader.read(length).mapIndexed((i, e) => e ^ binaryMaskingKey[i % 4]).toList();
        if (maskingKey != Crc32().convert(payload).toBigInt().toInt()) throw 'payload is tampered';
        return payload;
      } else {
        return contentReader.read(length).toList();
      }
    }

    // payload
    List<int> payload = [];
    try {
      if (length <= 125) {
        payload.addAll(getPayload(mask));
      } else if (length == 126) {
        length = contentReader.readInt16();
        payload.addAll(getPayload(mask));
      } else if (length == 127) {
        length = contentReader.readInt64();
        payload.addAll(getPayload(mask));
      }
      return SocketFrame._(SocketOpcode.fromCode(opcode), payload: payload);
    } catch (e) {
      return SocketFrame._(SocketOpcode.invalid, payload: payload);
    }
  }

  @override
  String toString() => payload.map((e) => e.toRadixString(16).padLeft(2, '0').toUpperCase()).join(' ');
}

extension SocketFrameExt on SocketFrame {
  int get length => payload.length;

  /// 将事件转为待发送的数据
  Uint8List toBytes([bool server = true]) {
    final contentWriter = ByteDataWriter();
    final sb = StringBuffer();
    // fin 指明Frame是否是一个Message里最后Frame, 1bit
    // RSV1-RSV3 3bit 都是0
    // opcode 4bit
    sb
      ..write(1)
      ..write(0)
      ..write(0)
      ..write(0)
      ..write(opcode.code.toRadixString(2).padLeft(4, '0'));
    contentWriter.writeUint8(int.parse(sb.toString(), radix: 2));

    sb.clear();
    // mask 1bit
    sb.write(server ? 0 : 1);
    final length = payload.length;
    // 如果length值在0-125，则是payload的真实长度7bit
    if (length <= 125) {
      sb.write(length.toRadixString(2).padLeft(7, '0'));
      contentWriter.writeUint8(int.parse(sb.toString(), radix: 2));
    }
    // 如果length<=32767, 固定值是126，则后面2个字节形成的16位无符号整型数的值是payload的真实长度。
    else if (length <= 32767) {
      sb.write(126.toRadixString(2).padLeft(7, '0'));
      contentWriter.writeUint8(int.parse(sb.toString(), radix: 2));
      contentWriter.writeUint16(length);
    }
    // 如果length>32767,固定值是127，则后面8个字节形成的64位无符号整型数的值是payload的真实长度
    else {
      sb.write(127.toRadixString(2).padLeft(7, '0'));
      contentWriter.writeUint8(int.parse(sb.toString(), radix: 2));
      contentWriter.writeUint64(length);
    }

    if (server) {
      contentWriter.write(payload);
    } else {
      // maskingKey 4byte
      final maskingKey = Crc32().convert(payload).toBigInt();
      contentWriter.writeUint32(maskingKey.toInt());

      final binaryMaskingKey = hex.decode(maskingKey.toRadixString(16).padLeft(8, '0'));
      final content = payload.mapIndexed((i, e) => e ^ binaryMaskingKey[i % 4]).toList();
      contentWriter.write(content);
    }
    return contentWriter.toBytes();
  }
}
