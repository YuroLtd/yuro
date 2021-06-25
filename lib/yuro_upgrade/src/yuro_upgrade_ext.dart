import 'package:package_info/package_info.dart';
import 'package:yuro/yuro_core/yuro_core.dart';

import 'upgrade_info.dart';

class _Upgrade {
  String? appId;
  PackageInfo? packageInfo;
}

extension YuroUpgradeExt on YuroInterface {
  static _Upgrade _upgrade = _Upgrade();

  /// 加载应用信息
  Future<void> loadPackageInfo() async => _upgrade.packageInfo = await PackageInfo.fromPlatform();

  /// 获取应用名称
  String? get appName => _upgrade.packageInfo?.appName;

  /// 获取应用包名
  String? get appPackageName => _upgrade.packageInfo?.packageName;

  /// 获取应用版本
  String? get appVersion => _upgrade.packageInfo?.version;

  /// 获取应用数字版本号
  String? get appBuildNumber => _upgrade.packageInfo?.buildNumber;

  /// 获取应用标识
  String? get appId => _upgrade.appId;

  /// 设置应用标识
  set appId(String? appId) => _upgrade.appId = appId;

  /// 检查应用是否有更新
  Future<UpgradeInfo>? checkUpgrade(String url) {
    return null;
  }
}
