import 'package:flutter/material.dart';
import 'package:yuro/utils/screen.dart';

class LabelValue extends StatelessWidget {
  final String label;
  final double labelWidth;
  final double labelMargin;
  final TextStyle? labelStyle;
  final String? value;
  final TextStyle? valueStyle;
  final TextAlign? valueAlign;
  final EdgeInsets? padding;

  const LabelValue(
    this.label,
    this.value, {
    this.labelWidth = 0.0,
    this.labelMargin = 10,
    this.labelStyle,
    this.valueStyle,
    this.valueAlign,
    this.padding,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Row(crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic, children: [
        Padding(
            padding: EdgeInsets.only(right: labelMargin),
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: labelWidth),
              child: Text(label, style: labelStyle),
            )),
        Expanded(child: Text(value ?? '', style: valueStyle, textAlign: valueAlign ?? TextAlign.end)),
      ]));
}

class VerticalLabelValue extends StatelessWidget {
  final String label;
  final TextStyle? labelStyle;
  final String? value;
  final TextStyle? valueStyle;
  final CrossAxisAlignment crossAxisAlignment;

  const VerticalLabelValue(
    this.label,
    this.value, {
    this.labelStyle,
    this.valueStyle,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Column(crossAxisAlignment: crossAxisAlignment, mainAxisSize: MainAxisSize.min, children: [
        Padding(padding: EdgeInsets.only(bottom: 3.w), child: Text(label, style: labelStyle)),
        Text(value ?? '', style: valueStyle),
      ]);
}
