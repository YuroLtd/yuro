import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// 在文本超出指定行数之后，会显示 展开/收起 按钮的文本展示组件
class CollapsibleText extends StatefulWidget {
  final String? text;

  /// 最少展示几行-在收起的状态下展示几行,必须大0
  final int minLines;

  /// 文字整体样式
  final TextStyle? textStyle;

  /// 收起、展开文字颜色
  final Color? linkColor;

  /// 收起状态下按钮文字
  final String shrinkText;

  ///  展开状态下的按钮文字
  final String expandText;

  /// 当点击展开、收起的时的回调
  final Function(bool isExpand)? onExpanded;

  /// 结尾按钮是否始终处于显示状态
  final bool isAlwaysDisplay;

  const CollapsibleText({
    Key? key,
    this.text,
    this.minLines = 2,
    this.textStyle,
    this.linkColor,
    this.shrinkText = '收起',
    this.expandText = '展开',
    this.isAlwaysDisplay = true,
    this.onExpanded,
  })  : assert(minLines > 0),
        super(key: key);

  @override
  CollapsibleTextState createState() => CollapsibleTextState();
}

class CollapsibleTextState extends State<CollapsibleText> {
  bool _isExpand = false;

  late TapGestureRecognizer _tapGestureRecognizer;

  @override
  void initState() {
    super.initState();
    _tapGestureRecognizer = TapGestureRecognizer()
      ..onTap = () => setState(() {
            _isExpand = !_isExpand;
            widget.onExpanded?.call(_isExpand);
          });
  }

  @override
  void dispose() {
    _tapGestureRecognizer.dispose();
    super.dispose();
  }

  TextPainter getTextPainter(String text, TextStyle textStyle, double minWidth, double maxWidth, [int? maxLines]) {
    return TextPainter(
      text: TextSpan(text: text, style: textStyle),
      textDirection: TextDirection.ltr,
      maxLines: maxLines,
    )..layout(minWidth: minWidth, maxWidth: maxWidth);
  }

  @override
  Widget build(BuildContext context) => LayoutBuilder(builder: (context, constraints) {
        assert(constraints.hasBoundedWidth);
        final text = widget.text;
        final textStyle = DefaultTextStyle.of(context).style.merge(widget.textStyle);
        var textSpan = TextSpan(text: text, style: textStyle);

        if (text != null && text.isNotEmpty) {
          var textPainter = getTextPainter(text, textStyle, constraints.maxWidth, constraints.maxWidth);
          final textLines = textPainter.computeLineMetrics();
          if (textLines.length > widget.minLines) {
            final blankWidth = getTextPainter(' ', textStyle, 0, constraints.maxWidth).width;
            final textLineList = text.split('\n');
            double textLineHeight = 0;
            for (int i = 0; i < textLineList.length; i++) {
              final blankNum = ((constraints.maxWidth - textLines[i].width) / blankWidth).floor();
              textLineList[i] = textLineList[i] + ' ' * blankNum;

              if (textLines[i].height > textLineHeight) textLineHeight = textLines[i].height;
            }

            final newText = textLineList.join();
            final maxLines = _isExpand ? null : widget.minLines;
            textPainter = getTextPainter(newText, textStyle, constraints.maxWidth, constraints.maxWidth, maxLines);
            final textSize = textPainter.size;

            final linkText = _isExpand ? widget.shrinkText : '...${widget.expandText}';
            final linkColor = widget.linkColor ?? Theme.of(context).colorScheme.secondary;
            final linkTextSpan = TextSpan(
              text: linkText,
              style: textStyle.copyWith(color: linkColor),
              recognizer: _tapGestureRecognizer,
            );
            final linkSize = getTextPainter(linkText, textStyle, 0, constraints.maxWidth).size;

            final position = textPainter.getPositionForOffset(Offset(textSize.width - linkSize.width, textSize.height));
            final endOffset = textPainter.getOffsetBefore(position.offset);
            final showText = _isExpand ? newText : newText.substring(0, endOffset);
            final lineHeightScale =
                linkSize.height > textLineHeight ? linkSize.height / textLineHeight : textLineHeight / linkSize.height;

            if (widget.isAlwaysDisplay) {
              textSpan = TextSpan(
                  text: showText, style: textStyle.copyWith(height: lineHeightScale), children: [linkTextSpan]);
            } else {
              textSpan = TextSpan(
                text: showText,
                style: textStyle.copyWith(height: lineHeightScale),
                children: textPainter.didExceedMaxLines ? [linkTextSpan] : [],
              );
            }
          }
        }
        return RichText(text: textSpan, softWrap: true, overflow: TextOverflow.clip);
      });
}
