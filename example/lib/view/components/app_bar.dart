import 'package:example/export.dart';
import 'package:flutter/material.dart';

/// 通用
AppBar appBar({String? title, List<Widget>? actions, Color? backgroundColor}) => AppBar(
      title: Text(title ?? ''),
      centerTitle: true,
      backgroundColor: backgroundColor ?? Yuro.app.theme?.surfaceVariant,
      actions: actions,
      elevation: 0,
    );
