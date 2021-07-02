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
  static SharedPreferences? _preferences;

  Future<SharedPreferences> get _prefs async => _preferences ??= await SharedPreferences.getInstance();

  Future<int?> getInt(String key) async => _prefs.then((sp) => sp.getInt(key));

  Future<String?> getString(String key) async => _prefs.then((sp) => sp.getString(key));

  Future<bool?> getBool(String key) async => _prefs.then((sp) => sp.getBool(key));

  Future<double?> getDouble(String key) async => _prefs.then((sp) => sp.getDouble(key));

  Future<List<String>?> getStringList(String key) async => _prefs.then((sp) => sp.getStringList(key));

  Future<bool> setInt(String key, int value) => _prefs.then((sp) => sp.setInt(key, value));

  Future<bool> setString(String key, String value) => _prefs.then((sp) => sp.setString(key, value));

  Future<bool> setBool(String key, bool value) => _prefs.then((sp) => sp.setBool(key, value));

  Future<bool> setDouble(String key, double value) => _prefs.then((sp) => sp.setDouble(key, value));

  Future<bool> setStringList(String key, List<String> value) => _prefs.then((sp) => sp.setStringList(key, value));

  Future<bool> hasKey(String key) => _prefs.then((sp) => sp.containsKey(key));

  Future<bool> removeKey(String key) => _prefs.then((sp) => sp.remove(key));

  Future<bool> clear(String key) => _prefs.then((sp) => sp.clear());
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
