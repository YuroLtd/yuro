import 'package:yuro/core/core.dart';
import 'package:yuro/storage/storage.dart';
import 'package:yuro/util/util.dart';

import 'src/bean/record.dart';
import 'src/logger.dart';

export 'src/bean/level.dart';
export 'src/bean/record.dart';
export 'src/logger.dart';

extension LoggerExt on YuroInterface {
  Logger tag(String tag) => Logger(tag);

  void v(dynamic message, {dynamic extra}) => logger.v(message, extra: extra);

  void d(dynamic message, {dynamic extra}) => logger.d(message, extra: extra);

  void i(dynamic message, {dynamic extra}) => logger.i(message, extra: extra);

  void w(dynamic message, {dynamic extra}) => logger.w(message, extra: extra);

  void e(dynamic message, {dynamic extra}) => logger.e(message, extra: extra);

  /// 按照[filter]导出日志, 如果[filter]为空,则导出全部日志,
  /// [clear]日志导出后是否清空日志缓存
  Future<List<LogRecord>> exportLog({bool Function(LogRecord)? filter, bool clear = true}) async {
    if (Yuro.isWeb) return [];
    final box = await Yuro.openHiveBox<LogRecord>();
    final records = box.values.where((element) => filter?.call(element) ?? true).toList();
    if (clear) box.clear();
    return records;
  }
}
