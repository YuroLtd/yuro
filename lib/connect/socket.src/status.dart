// ignore_for_file: constant_identifier_names

/// 客户端的连接状态
enum SocketStatus {
  not_connected(0, '未连接'),
  connecting(1, '连接中'),
  connected(2, '已连接'),
  failed(-1, '连接失败'),
  closed(-2, '连接关闭'),
  connect_timeout(-3, '连接超时');

  final int code;
  final String desc;

  const SocketStatus(this.code, this.desc);
}
