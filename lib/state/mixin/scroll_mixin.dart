import 'package:flutter/widgets.dart';
import 'package:yuro/state/viewmodel.dart';

mixin ScrollMixin on ViewModel {
  final ScrollController _scrollController = ScrollController();

  ScrollController get scrollController => _scrollController;

  bool _canLoadMore = true;

  set canLoadMore(bool value) => _canLoadMore = value;

  var _currentPage = 1;

  @override
  Future<void> onInit() async {
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
