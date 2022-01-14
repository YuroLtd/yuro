import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:yuro/yuro_core/yuro_core.dart';

extension YuroSpExt on YuroInterface {
  static late SharedPreferences _sp;

  Future<void> initSharedPreferences() async => _sp = await SharedPreferences.getInstance();

  SharedPreferences get sp => _sp;
}
