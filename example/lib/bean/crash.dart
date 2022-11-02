import 'dart:math';

import 'package:example/export.dart';
import 'package:yuro_plugin/yuro_plugin.dart';

part 'crash.g.dart';

@collection
class Crash {
  Id id = Isar.autoIncrement;
  final String error;
  final String stackTrace;
  @Index(unique: true, replace: true)
  final String md5;
  int count;
  final String? logFile;
  String? deviceId;
  String? deviceName;
  String? deviceSdk;
  String? deviceAbi;
  String? deviceRom;
  String? deviceNet;
  final String version;
  final String errorTime;
  bool uploaded;

  Crash(
    this.error,
    this.stackTrace,
    this.md5,
    this.logFile,
    this.version, {
    this.deviceId,
    this.deviceName,
    this.deviceSdk,
    this.deviceAbi,
    this.deviceRom,
    this.deviceNet,
    this.count = 1,
    this.uploaded = false,
  }) : errorTime = Yuro.currentDateTime.format();

  Map<String, dynamic> toJson() => <String, dynamic>{
        'appId': Yuro.find<Environment>().appId,
        'error': error,
        'stackTrace': stackTrace,
        'md5': md5,
        'count': count,
        'logFile': logFile.isNull ? null : MultipartFile.fromFileSync(logFile!),
        'deviceId': deviceId,
        'deviceName': deviceName,
        'deviceSdk': deviceSdk,
        'deviceAbi': deviceAbi,
        'deviceRom': deviceRom,
        'deviceNet': deviceNet,
        'version': version,
        'errorTime': errorTime,
      };

  factory Crash.fromDeviceInfo(String error, String stackTrace, String md5, String? logFile, DeviceInfo device) {
    stackTrace = stackTrace.substring(0, min(stackTrace.length, 1000));
    return Crash(error, stackTrace, md5, logFile, '$versionName($buildNumber)').._updateDeviceInfo(device);
  }

  Crash update(String? logFile, DeviceInfo device) {
    return Crash(error, stackTrace, md5, logFile, '$versionName($buildNumber)')
      ..count = ++count
      .._updateDeviceInfo(device);
  }

  void _updateDeviceInfo(DeviceInfo device) {
    if (Yuro.isAndroid && device.android != null) {
      deviceId = device.android?.androidId;
      deviceName = '${device.android?.brand} ${device.android?.model}';
      deviceSdk = device.android?.sdk;
      deviceAbi = device.android?.abis.split(',').first;
      deviceRom = device.android?.userAgent.replaceAll(')', '').split(';').last.trim();
      deviceNet = device.android?.networkType.desc;
    }
  }
}
