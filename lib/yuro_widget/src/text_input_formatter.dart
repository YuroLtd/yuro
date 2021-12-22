import 'package:flutter/services.dart';
import 'package:yuro/yuro_extension/yuro_extension.dart';

extension TextInputFormatters on TextInputFormatter {
  static List<TextInputFormatter> money({int integer = 6, int decimal = 2}) =>
      [_MoneyTextInputFormatter(integer, decimal), allow(RegExp(r'[0-9.]'))];

  static TextInputFormatter allow(Pattern filterPattern, {String replacementString = ''}) =>
      FilteringTextInputFormatter.allow(filterPattern, replacementString: replacementString);

  static TextInputFormatter deny(Pattern filterPattern, {String replacementString = ''}) =>
      FilteringTextInputFormatter.deny(filterPattern, replacementString: replacementString);

  static TextInputFormatter get digitsOnly => FilteringTextInputFormatter.digitsOnly;

  static TextInputFormatter get singleLineFormatter => FilteringTextInputFormatter.singleLineFormatter;
}

class _MoneyTextInputFormatter extends TextInputFormatter {
  final int integer;
  final int decimal;

  _MoneyTextInputFormatter(this.integer, this.decimal);

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // 数字开头不允许出现"00"
    if (oldValue.text.startsWith('0') && newValue.text.startsWith('00')) {
      return oldValue;
    }

    // 起始输入小数点时自动补上整数部分
    if (oldValue.text.isEmpty && newValue.text == '.') {
      return const TextEditingValue(text: '0.', selection: TextSelection.collapsed(offset: 2));
    }

    // 限制整数部分长度不超过给定值
    if (newValue.text.toDouble() != null) {
      final value = newValue.text.toDouble();
      if (value!.truncate().toString().length > integer) {
        return oldValue;
      }
    }

    if (oldValue.text.contains('.')) {
      // 小数部分不允许出现第二个小数点
      if (newValue.text.indexOf('.') != newValue.text.lastIndexOf('.')) {
        return oldValue;
      }

      final decimalPart = newValue.text.split('.');
      // 如果新值的小数位大于指定值,返回旧值
      if (decimalPart.length == 2 && decimalPart[1].length > decimal) {
        return oldValue;
      }
    }
    return newValue;
  }
}
