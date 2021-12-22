import 'dart:math';

import 'package:flutter/material.dart';

/// 自定义滑块开关组件
///
/// @param onChanged    当开关状态发生改变时，会回调该函数.
///
/// @param open         是否处于打开状态,默认false.
///
/// @param enable       是否为可用状态,默认true.
///
/// @param width        组件宽度。默认45.
///
/// @param onColor      打开状态下的背景色.
///
/// @param onChild      打开状态的提示样式.
///
/// @param offColor     关闭状态下的背景色.
///
/// @param offChild     关闭状态的提示样式.
///
/// @param sliderColor  滑块颜色.
///
/// @param sliderChild  滑块中的组件。超过范围会被剪裁.
///
/// @param boxShadow    组件阴影.
class Switcher extends StatefulWidget {
  final bool open;
  final ValueChanged<bool> onChanged;
  final bool enable;

  final double width;
  final double height;
  final double offset;

  final Color onColor;
  final Widget? onChild;
  final Color offColor;
  final Widget? offChild;
  final double childOffset;

  final Color? sliderColor;
  final Widget? sliderChild;

  final List<BoxShadow>? boxShadow;

  const Switcher({
    Key? key,
    required this.onChanged,
    this.open = false,
    this.enable = true,
    this.width = 45,
    //
    this.onColor = const Color(0xFF26B85C),
    this.onChild,
    this.offColor = const Color(0xFFCCCCCC),
    this.offChild,
    //
    this.sliderColor,
    this.sliderChild,
    //
    this.boxShadow,
  })  : height = width * 0.5,
        offset = width * 0.5 / 18,
        childOffset = width * 0.5 / 5,
        super(key: key);

  @override
  _SwitcherState createState() => _SwitcherState();
}

class _SwitcherState extends State<Switcher> {
  late bool isOpen = widget.open;
  late double circleSize = widget.height * 32.52 / 36.0;
  late double maxOffset = widget.width - widget.offset * 2 - circleSize;
  late double sliderDragW = circleSize / 2;
  late double sliderOffset = isOpen ? maxOffset : 0;

  bool draging = false;

  @override
  Widget build(BuildContext context) {
    var children = <Widget>[];
    var background = AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      decoration: BoxDecoration(
        color: isOpen ? widget.onColor : widget.offColor,
        borderRadius: BorderRadius.circular(widget.height / 2),
        boxShadow: widget.boxShadow,
      ),
      child: SizedBox(width: widget.width, height: widget.height),
    );
    children.add(background);

    var showChild = isOpen ? widget.onChild : widget.offChild;
    if (showChild != null) {
      showChild = Positioned(
          child: showChild, left: isOpen ? widget.childOffset : null, right: isOpen ? null : widget.childOffset);
      children.add(showChild);
    }

    var slider = AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: EdgeInsets.fromLTRB(widget.offset + sliderOffset, 0, 0, 0),
        width: circleSize + ((draging && sliderOffset != maxOffset) ? sliderDragW : 0),
        height: circleSize,
        child: Container(
          clipBehavior: Clip.antiAlias,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: widget.sliderColor ?? Colors.white,
            borderRadius: BorderRadius.circular(circleSize / 2),
          ),
          child: widget.sliderChild,
        ));
    children.add(slider);

    if (!widget.enable) {
      var disableMask = Opacity(
          opacity: 0.6,
          child: Container(
              width: widget.width,
              height: widget.height,
              decoration: BoxDecoration(
                color: const Color(0xFFF1F1F1),
                borderRadius: BorderRadius.circular(widget.height / 2),
              )));
      children.add(disableMask);
    }

    return GestureDetector(
      onTap: widget.enable ? _handlerOnTap : null,
      onHorizontalDragStart: widget.enable ? _handlerOnHorizontalDragStart : null,
      onHorizontalDragUpdate: widget.enable ? _handlerOnHorizontalDragUpdate : null,
      onHorizontalDragEnd: widget.enable ? _handlerOnHorizontalDragEnd : null,
      onHorizontalDragCancel: widget.enable ? _handlerOnHorizontalDragCancel : null,
      child: Stack(alignment: Alignment.centerLeft, children: children),
    );
  }

  void _handlerOnTap() {
    setState(() {
      isOpen = !isOpen;
      sliderOffset = isOpen ? maxOffset : 0;
      widget.onChanged.call(isOpen);
    });
  }

  void _handlerOnHorizontalDragStart(DragStartDetails details) {
    setState(() => draging = true);
  }

  void _handlerOnHorizontalDragUpdate(DragUpdateDetails details) {
    setState(() {
      sliderOffset = sliderOffset + details.delta.dx;
      sliderOffset = sliderOffset < 0 ? 0 : min(sliderOffset, maxOffset - sliderDragW);
    });
  }

  void _handlerOnHorizontalDragEnd(DragEndDetails details) {
    setState(() {
      draging = false;
      var openCache = isOpen;
      if (sliderOffset < (maxOffset - sliderDragW) / 2) {
        isOpen = false;
        sliderOffset = 0;
      } else {
        isOpen = true;
        sliderOffset = maxOffset;
      }
      if (openCache != isOpen) widget.onChanged.call(isOpen);
    });
  }

  void _handlerOnHorizontalDragCancel() {
    setState(() => draging = false);
  }
}
