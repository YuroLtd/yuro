library yuro_cache;

import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:yuro/yuro_core/yuro_core.dart';
import 'package:yuro/yuro_extension/yuro_extension.dart';

import 'src/yuro_cache.dart';

export 'src/yuro_cache.dart';
export 'src/closeable.dart';
export 'src/lru_map.dart';

extension SharedPreferencesExt on YuroInterface {
  static SharedPreferences? _sp;

  Future<void> initSharedPreferences() async => _sp = await SharedPreferences.getInstance();

  SharedPreferences get sp {
    assert(_sp != null, 'SharedPreferences 还未完成初始化');
    return _sp!;
  }
}

// extension YuroCacheExt on YuroInterface {
//   static YuroCache? _cache;
//
//   Future<YuroCache> openCache({Directory? directory, int? maxSize}) async {
//     return _cache ??= await YuroCache.open(directory ?? await Yuro.temporaryDirectory, maxSize ?? 100.MB);
//   }
//
//   YuroCache _checkCacheInitialized() {
//     assert(_cache != null, '请先调用"Yuro.openCache()"方法完成初始化.');
//     return _cache!;
//   }
//
//   Future<Snapshot?> getCache(String key) async => await _checkCacheInitialized().get(key.toMd5());
//
//   Future<Editor?> editCache(String key, [Duration? expire]) async => await _checkCacheInitialized().edit(key.toMd5(), expire);
//
//   Future<bool> removeCache(String key) async => await _checkCacheInitialized().remove(key.toMd5());
//
//   Future<void> clearCache() => _checkCacheInitialized().clear();
//
//   int getCacheSize() => _checkCacheInitialized().getSize();
// }
