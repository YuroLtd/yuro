import 'package:flutter/widgets.dart';
import 'package:yuro/state/viewmodel.dart';

mixin ScrollMixin on BaseViewModel {
  final ScrollController _scrollController = ScrollController();

  ScrollController get scrollController => _scrollController;

  bool _canLoadMore = true;

  set canLoadMore(bool value) => _canLoadMore = value;

  var _currentPage = 1;

  @override
  void onInit() {
    _scrollController.addListener(_scrollListener);
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    onRefresh();
  }

  void _scrollListener() {
    if (_scrollController.position.atEdge) {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        // 滚动到底部触发加载更多
        if (_canLoadMore) loadMore();
      }
    }
  }

  Future<void> onRefresh() => loadData(_currentPage = 1);

  void loadMore() => loadData(++_currentPage);

  Future<void> loadData(int page);

  @override
  void dispose() {
    super.dispose();
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
  }
}
