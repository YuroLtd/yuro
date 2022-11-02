import 'package:example/export.dart';
import 'package:yuro_annotation/yuro_annotation.dart';

part 'system.g.dart';

@Retrofit(path: '/publish')
abstract class SystemApi {
  /// 获取应用的最新版本
  @Multipart()
  @POST('/open/api/appLogUpload')
  Future<void> crashReport(@PartMap() Crash crash);
}
