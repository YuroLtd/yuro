import 'package:package_info/package_info.dart';
import 'package:yuro/yuro_core/yuro_core.dart';

extension PackageInfoExt on YuroInterface {
  static PackageInfo? _packageInfo;

  /// 加载应用信息
  Future<void> loadPackageInfo() async => _packageInfo = await PackageInfo.fromPlatform();

  /// 获取应用名称
  String? get appName => _packageInfo?.appName;

  /// 获取应用包名
  String? get packageName => _packageInfo?.packageName;

  /// 获取应用版本
  String? get versionName => _packageInfo?.version;

  /// 获取应用数字版本号
  String? get versionCode => _packageInfo?.buildNumber;
}
