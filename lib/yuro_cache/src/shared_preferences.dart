
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yuro/yuro_core/yuro_core.dart';

extension SharedPreferencesExt on YuroInterface {
  static SharedPreferences? _sp;

  Future<void> initSharedPreferences() async => _sp = await SharedPreferences.getInstance();

  SharedPreferences get sp {
    assert(_sp != null, 'SharedPreferences 还未完成初始化');
    return _sp!;
  }
}