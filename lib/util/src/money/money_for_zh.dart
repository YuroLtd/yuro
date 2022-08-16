class MoneyForZh {
  // 大写数字
  static const List<String> _zhNumber = ['零', '壹', '贰', '叁', '肆', '伍', '陆', '柒', '捌', '玖'];

  // 整数部分的单位
  static const List<String> _integer = ['元', '拾', '佰', '仟', '万', '拾', '佰', '仟', '亿', '拾', '佰', '仟', '万', '拾', '佰', '仟'];

  // 小数部分的单位
  static const List<String> _decimal = ['角', '分', '厘'];

  //转成中文的大写金额
  String toChinese(String str) {
    if (str == '0' || str == '0.00') return '零元';
    // 去掉','
    str = str.replaceAll(',', '');
    // 整数部分数字
    String integerStr;
    // 小数部分数字
    String decimalStr;
    // 初始化：分离整数部分和小数部分
    if (str.indexOf('.') > 0) {
      integerStr = str.substring(0, str.indexOf('.'));
      decimalStr = str.substring(str.indexOf('.') + 1);
    } else if (str.indexOf('.') == 0) {
      integerStr = '';
      decimalStr = str.substring(1);
    } else {
      integerStr = str;
      decimalStr = '';
    }

    // 超出计算能力，直接返回
    if (integerStr.length > _integer.length) {
      throw Exception('"$str"：超出计算能力');
    }

    // 整数部分数字
    var integers = _toIntArray(integerStr);
    // 设置万单位
    bool isWan = _isWanYuan(integerStr);
    // 小数部分数字
    var decimals = _toIntArray(decimalStr);
    // 返回最终的大写金额
    return _getChineseInteger(integers, isWan) + _getChineseDecimal(decimals);
  }

  // 将字符串转为int数组
  List<int> _toIntArray(String number) {
    List<int> array = [];
    if (array.length > number.length) {
      throw Exception('数组越界异常');
    } else {
      for (int i = 0; i < number.length; i++) {
        array.insert(i, int.parse(number.substring(i, i + 1)));
      }
      return array;
    }
  }

  // 判断当前整数部分是否已经是达到【万】
  bool _isWanYuan(String integerStr) {
    int length = integerStr.length;
    if (length > 4) {
      String subInteger = '';
      if (length > 8) {
        subInteger = integerStr.substring(length - 8, length - 4);
      } else {
        subInteger = integerStr.substring(0, length - 4);
      }
      return int.parse(subInteger) > 0;
    } else {
      return false;
    }
  }

  // 将整数部分转为大写的金额
  String _getChineseInteger(var integers, bool isWan) {
    StringBuffer chineseInteger = StringBuffer('');
    int length = integers.length;
    for (int i = 0; i < length; i++) {
      String key = '';
      if (integers[i] == 0) {
        // 万（亿）
        if ((length - i) == 13) {
          key = _integer[4];
        }
        // 亿
        else if ((length - i) == 9) {
          key = _integer[8];
        }
        // 万
        else if ((length - i) == 5 && isWan) {
          key = _integer[4];
        }
        // 元
        else if ((length - i) == 1) {
          key = _integer[0];
        }
        if ((length - i) > 1 && integers[i + 1] != 0) {
          key += _zhNumber[0];
        }
      }
      chineseInteger.write(integers[i] == 0 ? key : (_zhNumber[integers[i]] + _integer[length - i - 1]));
    }
    return chineseInteger.toString();
  }

  // 将小数部分转为大写的金额
  String _getChineseDecimal(var decimals) {
    StringBuffer chineseDecimal = StringBuffer('');
    for (int i = 0; i < decimals.length; i++) {
      if (i == 3) break;
      chineseDecimal.write(decimals[i] == 0 ? '' : (_zhNumber[decimals[i]] + _decimal[i]));
    }
    return chineseDecimal.toString();
  }
}
