library yuro_cache;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:yuro/yuro_core/yuro_core.dart';

export 'src/lru_cache/disk_lru_cache.dart';

extension YuroCacheExt on YuroInterface {
  static late SharedPreferences _sp;

  Future<void> initSharedPreferences() async => _sp = await SharedPreferences.getInstance();

  SharedPreferences get sp => _sp;
}
