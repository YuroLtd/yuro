import 'package:flutter_user_agentx/flutter_user_agent.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:yuro/yuro_core/src/interface.dart';

extension PackageInfoExt on YuroInterface {
  static late PackageInfo _packageInfo;

  Future<void> loadPackageInfo() async {
    _packageInfo = await PackageInfo.fromPlatform();
  }

  Future loadUserAgent() => FlutterUserAgent.init();

  /// 获取应用名称
  String get appName => _packageInfo.appName;

  /// 获取应用包名
  String get packageName => _packageInfo.packageName;

  /// 获取应用版本
  String get versionName => _packageInfo.version;

  /// 获取应用数字版本号
  String get versionCode => _packageInfo.buildNumber;

  String get buildSignature => _packageInfo.buildSignature;

  /// 获取userAgent
  String? get userAgent => FlutterUserAgent.userAgent;

  String? get webViewUserAgent => FlutterUserAgent.webViewUserAgent;
}
