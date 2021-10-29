import 'package:flutter/services.dart';

extension TextInputFormatters on TextInputFormatter {
  static TextInputFormatter money([int decimalPlaces = 2]) => _MoneyTextInputFormatter(decimalPlaces);

  static TextInputFormatter allow(Pattern filterPattern, {String replacementString = ''}) =>
      FilteringTextInputFormatter.allow(filterPattern, replacementString: replacementString);

  static TextInputFormatter deny(Pattern filterPattern, {String replacementString = ''}) =>
      FilteringTextInputFormatter.deny(filterPattern, replacementString: replacementString);

  static TextInputFormatter get digitsOnly => FilteringTextInputFormatter.digitsOnly;

  static TextInputFormatter get singleLineFormatter => FilteringTextInputFormatter.singleLineFormatter;
}

class _MoneyTextInputFormatter extends TextInputFormatter {
  final int decimalPlaces;

  _MoneyTextInputFormatter(this.decimalPlaces);

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    print('${oldValue.text},${newValue.text} \n \n');
    // 数字开头不允许出现"00"
    if (oldValue.text.startsWith('0') && newValue.text.startsWith('00')) {
      return oldValue;
    }

    // 起始输入小数点时自动补上整数部分
    if (oldValue.text.isEmpty && newValue.text == '.') {
      return TextEditingValue(text: '0.', selection: TextSelection.collapsed(offset: 2));
    }

    if (oldValue.text.contains('.')) {
      // 小数部分不允许出现第二个小数点
      if (newValue.text.indexOf('.') != newValue.text.lastIndexOf('.')) {
        return oldValue;
      }

      final decimal = newValue.text.split('.');
      // 如果新值的小数位大于指定值,返回旧值
      if (decimal.length == 2 && decimal[1].length > decimalPlaces) {
        return oldValue;
      }
    }
    return newValue;
  }
}
