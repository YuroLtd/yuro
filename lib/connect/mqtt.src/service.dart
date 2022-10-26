import 'dart:io';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:yuro/core/core.dart';
import 'package:yuro/state/state.dart';
import 'package:yuro/util/util.dart';

abstract class MqttService extends YuroService {
  late MqttServerClient _client;

  String get tag => 'Mqtt';

  /// 连接地址
  String get server;

  /// 连接端口,默认1883
  int get port => MqttClientConstants.defaultMqttPort;

  /// 客户标识符
  String get clientIdentifier => '';

  /// 最大连接尝试次数,默认3
  int get maxConnectionAttempts => 3;

  late final _logger = Yuro.tag(tag);

  @override
  void onInit() {
    _client = MqttServerClient.withPort(server, clientIdentifier, port, maxConnectionAttempts: maxConnectionAttempts);
    _client.onConnected = onConnected;
    _client.onSubscribed = onSubscribed;
    _client.onSubscribeFail = onSubscribeFail;
    _client.pongCallback = pong;
    _client.onDisconnected = onDisconnected;
  }

  /// 连接成功的回调
  void onConnected() {
    _logger.v('onConnected');
  }

  /// 订阅成功回调
  void onSubscribed(String topic) {
    _logger.v('onSubscribed: $topic');
  }

  /// 订阅失败回调
  void onSubscribeFail(String topic) {
    _logger.v('onSubscribeFail: $topic');
  }

  /// ping-pong回调
  void pong() {
    _logger.v('pong');
  }

  /// 未经请求的断开连接的回调
  void onDisconnected() {
    _logger.v('onDisconnected');
  }
}

extension MqttServiceMixin on MqttService {
  /// 是否开启日志打印
  void logging(bool open) => _client.logging(on: open);

  /// 心跳周期
  set keepAlivePeriod(int period) => _client.keepAlivePeriod = period;

  /// 超时未收到心跳断开连接
  set disconnectOnNoResponsePeriod(int period) => _client.disconnectOnNoResponsePeriod = period;

  /// 设置协议版本为v3.1
  void setProtocolV31() => _client.setProtocolV31();

  /// 设置协议版本为v3.1.1
  void setProtocolV311() => _client.setProtocolV311();

  /// 设置连接消息
  void setConnectMessage(MqttConnectMessage message) => _client.connectionMessage = message;

  /// 获取连接状态
  MqttClientConnectionStatus? get status => _client.connectionStatus;

  /// 开启连接
  Future<void> connect([String? username, String? password]) async {
    try {
      await _client.connect(username, password);
    } on NoConnectionException catch (e) {
      _logger.e('client exception. $e');
      _client.disconnect();
    } on SocketException catch (e) {
      _logger.e('socket exception. $e');
      _client.disconnect();
    }
  }

  /// 检查已连接
  bool _checkConnected() => status?.state == MqttConnectionState.connected;

  /// 开启订阅
  void subscribe(String topic, MqttQos qosLevel) {
    if (!_checkConnected()) {
      _logger.w('client connection status check failed. current is $status}');
      return;
    }
    _client.subscribe(topic, qosLevel);
    // todo 代码未完
  }

  /// 取消订阅
  void unsubscribe(String topic, [bool expectAcknowledge = false]) =>
      _client.unsubscribe(topic, expectAcknowledge: expectAcknowledge);

  /// 发布一个消息, 返回消息id,如果发送失败返回null
  int? publishMessage(String topic, MqttQos qosLevel, MqttClientPayloadBuilder builder, [bool retain = false]) {
    try {
      return _client.publishMessage(topic, qosLevel, builder.payload!, retain: retain);
    } catch (_) {
      return null;
    }
  }

  /// 关闭连接
  void disconnect() => _client.disconnect();
}
