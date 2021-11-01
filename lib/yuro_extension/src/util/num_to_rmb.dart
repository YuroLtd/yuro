class NumToRMB {
  // 大写数字
  static const List<String> NUMBERS = ['零', '壹', '贰', '叁', '肆', '伍', '陆', '柒', '捌', '玖'];

  // 整数部分的单位
  static const List<String> I_UNIT = ['元', '拾', '佰', '仟', '万', '拾', '佰', '仟', '亿', '拾', '佰', '仟', '万', '拾', '佰', '仟'];

  // 小数部分的单位
  static const List<String> D_UNIT = ['角', '分', '厘'];

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
    if (integerStr.length > I_UNIT.length) {
      print(str + '：超出计算能力');
      return str;
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
  static List<int> _toIntArray(String number) {
    List<int> array = [];
    if (array.length > number.length) {
      throw new Exception('数组越界异常');
    } else {
      for (int i = 0; i < number.length; i++) {
        array.insert(i, int.parse(number.substring(i, i + 1)));
      }
      return array;
    }
  }

  // 判断当前整数部分是否已经是达到【万】
  static bool _isWanYuan(String integerStr) {
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
    StringBuffer chineseInteger = new StringBuffer('');
    int length = integers.length;
    for (int i = 0; i < length; i++) {
      String key = '';
      if (integers[i] == 0) {
        // 万（亿）
        if ((length - i) == 13)
          key = I_UNIT[4];
        else if ((length - i) == 9) {
          // 亿
          key = I_UNIT[8];
        } else if ((length - i) == 5 && isWan) {
          // 万
          key = I_UNIT[4];
        } else if ((length - i) == 1) {
          // 元
          key = I_UNIT[0];
        }
        if ((length - i) > 1 && integers[i + 1] != 0) {
          key += NUMBERS[0];
        }
      }
      chineseInteger.write(integers[i] == 0 ? key : (NUMBERS[integers[i]] + I_UNIT[length - i - 1]));
    }
    return chineseInteger.toString();
  }

  // 将小数部分转为大写的金额
  String _getChineseDecimal(var decimals) {
    StringBuffer chineseDecimal = new StringBuffer('');
    for (int i = 0; i < decimals.length; i++) {
      if (i == 3) break;
      chineseDecimal.write(decimals[i] == 0 ? '' : (NUMBERS[decimals[i]] + D_UNIT[i]));
    }
    return chineseDecimal.toString();
  }
}
