import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// 在文本超出指定行数之后，会显示 展开/收起 按钮的文本展示组件
class ExpandableText extends StatefulWidget {
  final String? content;

  /// 最少展示几行-在收起的状态下展示几行,必须大0
  final int minLines;

  /// 文字整体样式
  final TextStyle? style;

  /// 收起、展开文字颜色, 默认[Theme.of(context).colorScheme.primary]
  final Color? linkColor;

  /// 收起、展开文字的背景色, 默认[Theme.of(context).scaffoldBackgroundColor]
  final Color? linkBackground;

  /// 收起状态下按钮文字
  final String foldedText;

  ///  展开状态下的按钮文字
  final String expandedText;

  /// 结尾按钮是否在展开后继续显示
  final bool alwaysDisplay;

  /// 当点击展开、收起的时的回调
  final Function(bool isExpand)? onExpanded;

  const ExpandableText(
    this.content, {
    this.minLines = 2,
    this.style,
    this.linkColor,
    this.linkBackground,
    this.foldedText = '收起',
    this.expandedText = '展开',
    this.alwaysDisplay = true,
    this.onExpanded,
    super.key,
  }) : assert(minLines > 0);

  @override
  ExpandableTextState createState() => ExpandableTextState();
}

class ExpandableTextState extends State<ExpandableText> {
  bool _expanded = false;

  TextStyle get _textStyle => DefaultTextStyle.of(context).style.merge(widget.style);

  Color get _linkColor => widget.linkColor ?? Theme.of(context).colorScheme.primary;

  Color get _linkBackground => widget.linkBackground ?? Theme.of(context).scaffoldBackgroundColor;

  void toggleExpanded(bool expanded) => setState(() {
        _expanded = expanded;
        widget.onExpanded?.call(_expanded);
      });

  Widget _buildExpand(Size size) => SizedBox.fromSize(
      size: size,
      child: Stack(children: [
        Positioned.fill(
          child: Text(
            widget.content ?? '',
            style: _textStyle,
            maxLines: widget.minLines,
            overflow: TextOverflow.clip,
          ),
        ),
        Positioned(
            right: 0,
            bottom: 0,
            child: Container(
                padding: const EdgeInsets.only(left: 15),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [_linkBackground.withAlpha(100), _linkBackground, _linkBackground],
                    stops: const [0.1, 0.3, 1],
                  ),
                ),
                child: GestureDetector(
                    child: Text(widget.expandedText, style: _textStyle.copyWith(color: _linkColor)),
                    onTap: () => toggleExpanded(true))))
      ]));

  Widget _buildFold() => RichText(
      text: TextSpan(
          text: widget.content,
          style: _textStyle,
          children: widget.alwaysDisplay
              ? [
                  TextSpan(
                      text: '\n${widget.foldedText}',
                      style: _textStyle.copyWith(color: _linkColor),
                      recognizer: TapGestureRecognizer()..onTap = () => toggleExpanded(false))
                ]
              : null));

  @override
  Widget build(BuildContext context) => LayoutBuilder(builder: (context, constraints) {
        assert(constraints.hasBoundedWidth);
        var textSpan = TextSpan(text: widget.content, style: _textStyle);
        final textPainter = TextPainter(
          text: textSpan,
          textDirection: TextDirection.ltr,
          maxLines: widget.minLines,
        );
        textPainter.layout(minWidth: constraints.minWidth, maxWidth: constraints.maxWidth);
        if (textPainter.didExceedMaxLines) {
          return _expanded ? _buildFold() : _buildExpand(textPainter.size);
        } else {
          return Text(widget.content ?? '', style: _textStyle);
        }
      });
}
