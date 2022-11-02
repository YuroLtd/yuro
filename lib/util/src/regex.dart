extension RegexExt on String {
  bool _regExp(String reg) => RegExp(reg).hasMatch(this);

  /// 判断字符串是否是手机号
  bool isPhone() => _regExp(r'^1(3|4|5|6|7|8|9)\d{9}$');

  /// 判断字符串是否是Url
  bool isUrl() => _regExp(r'^((ht|f)tps?):\/\/[\w\-]+(\.[\w\-]+)+([\w\-\.,@?^=%&:\/~\+#]*[\w\-\@?^=%&\/~\+#])?$');

  /// 判断字符串是否是邮箱地址
  bool isEmail() => _regExp(r'\w[-\w.+]*@([A-Za-z0-9][-A-Za-z0-9]+\.)+[A-Za-z]{2,14}');

  bool isIPv4()=> _regExp(r'((25[0-5]|2[0-4]\d|[01]?\d\d?)\.){3}(25[0-5]|2[0-4]\d|[01]?\d\d?)');

  // bool isIPv6()=> _regExp(r'^(([\da-fA-F]{1,4}):){8}$');
}
