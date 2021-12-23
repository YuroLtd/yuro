extension StringExt on String {
  int? toInt() => int.tryParse(this);

  bool isDigit() => int.tryParse(this) != null;

  double? toDouble() => double.tryParse(this);

  /// 判断字符串是否是手机号
  bool isPhone() => RegExp(r'^1(3|4|5|6|7|8|9)\d{9}$').hasMatch(this);

  /// 判断字符串是否是Url
  bool isUrl() =>
      RegExp(r'^((ht|f)tps?):\/\/[\w\-]+(\.[\w\-]+)+([\w\-\.,@?^=%&:\/~\+#]*[\w\-\@?^=%&\/~\+#])?$').hasMatch(this);
}

extension String2Ext on String? {
  bool isNullOrEmpty() => this == null || this!.isEmpty;

  bool isNullOrBlank() => this == null || this!.trim().isEmpty;
}
