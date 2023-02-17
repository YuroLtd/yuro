part of '../yuro_controller.dart';

mixin ScrollMixin on YuroController {
  final ScrollController _scrollController = ScrollController();

  ScrollController get scrollController => _scrollController;

  bool _canLoadMore = true;

  set canLoadMore(bool value) => _canLoadMore = value;

  @override
  void onInit() {
    super.onInit();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.position.atEdge) {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        // 滚动到底部触发加载更多
        if (_canLoadMore) loadMore();
      }
    }
  }

  Future<void> onRefresh();

  void loadMore();

  @override
  void onDispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.onDispose();
  }
}
