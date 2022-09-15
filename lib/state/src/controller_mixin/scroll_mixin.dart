import 'package:flutter/widgets.dart';

import '../yuro_controller.dart';

mixin ScrollMixin on YuroController {
  final ScrollController _scrollController = ScrollController();

  ScrollController get scrollController => _scrollController;

  @override
  void onInit() {
    _scrollController.addListener(_scrollListener);
    super.onInit();
  }

  void _scrollListener() {
    if (_scrollController.position.atEdge) {
      if (_scrollController.position.pixels == 0) {
        // todo 滚动到顶部触发
      } else {
        // todo 滚动到底部触发
      }
    }
  }

  @override
  void onDispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.onDispose();
  }
}
