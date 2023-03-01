import 'dart:io';

// ignore: library_prefixes
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:yuro/core/core.dart';

extension PathProviderExt on YuroInterface {
  /// 获取下载目录(仅桌面可用 安卓和IOS报错)
  Future<Directory?> get downloadsDirectory => pathProvider.getDownloadsDirectory();

  /// 获取外部存储目录列表(仅安卓可用)
  ///
  /// 可以存储应用程序特定数据的目录
  ///
  /// 这些路径通常驻留在外部存储上 用户可见 如单独的分区或SD卡(可以有多个 所以是列表)
  ///
  /// Android: /storage/emulated/0/Android/data/<package>/files
  Future<List<Directory>?> get externalStorageDirectories => pathProvider.getExternalStorageDirectories();

  /// 获取外部缓存目录(仅安卓可用)
  ///
  /// 可以存储应用程序特定外部存储数据的目录
  ///
  /// 这些路径通常驻留在外部存储上，如单独的分区或SD卡(可以有多个 所以是列表)
  ///
  /// Android: /storage/emulated/0/Android/data/<package>/cache
  Future<List<Directory>?> get externalCacheDirectories => pathProvider.getExternalCacheDirectories();

  /// 获取外部存储目录(仅安卓可用)
  ///
  /// 获取外部存储目录 用户可见
  ///
  /// Android: /storage/emulated/0/Android/data/<package>/files
  Future<Directory?> get externalStorageDirectory => pathProvider.getExternalStorageDirectory();

  /// 获取应用文件目录(IOS和安卓通用)
  ///
  /// 用于放置用户生成的数据或不能有应用程序重新创建的数据 用户不可见
  ///
  /// Android: /data/user/0/<package>/app_flutter
  Future<Directory> get applicationDocumentsDirectory => pathProvider.getApplicationDocumentsDirectory();

  /// 获取应用持久存储目录路径(仅IOS可用)
  ///
  /// 应用程序可以存储持久化、备份和用户不可见的文件的目录路径
  Future<Directory> get libraryDirectory => pathProvider.getLibraryDirectory();

  /// 获取应用支持目录(IOS和安卓通用)
  ///
  /// 用于存储应用支持的目录 这个目录对于用户是不可见的
  ///
  /// Android: /data/user/0/<package>/files
  Future<Directory> get applicationSupportDirectory => pathProvider.getApplicationSupportDirectory();

  /// 获取临时文件路径(IOS和安卓通用)
  ///
  /// 不会备份并且随时会被删除的临时目录
  ///
  /// Android: /data/user/0/<package>/cache
  Future<Directory> get temporaryDirectory => pathProvider.getTemporaryDirectory();
}
