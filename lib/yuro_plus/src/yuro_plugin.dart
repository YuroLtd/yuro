import 'package:yuro/yuro_core/yuro_core.dart';
import 'package:yuro_plugin/yuro_plugin.dart';

extension PackageInfoExt on YuroInterface {
  static late AppInfo _appInfo;

  /// 加载应用信息
  Future<void> loadAppInfo() async => _appInfo = await YuroPlugin().app.appInfo();

  /// 获取应用名称
  String get appName => _appInfo.appName;

  /// 获取应用包名
  String get packageName => _appInfo.packageName;

  /// 获取应用版本
  String get versionName => _appInfo.versionName;

  /// 获取应用数字版本号
  int get versionCode => _appInfo.versionCode;

  /// 获取androidId
  String? get androidId => _appInfo.androidId;

  /// 获取userAgent
  String get userAgent => _appInfo.userAgent;
}
