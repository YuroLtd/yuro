import 'package:yuro/route/navigator_observer.dart';
import 'package:yuro/state/viewmodel.dart';

mixin NavigatorMixin on ViewModel {
  @override
  Future<void> onInit() {
    YuroNavigatorObserver.register(state.name ?? state.location, this);
    return super.onInit();
  }

  @override
  void dispose() {
    YuroNavigatorObserver.unRegister(state.name ?? state.location);
    super.dispose();
  }

  /// 上层的页面弹出
  void didPopNext() {
    onResumed();
  }

  /// 当前页面出栈
  void didPop() {}

  /// 当前页面入栈
  void didPush() {}

  /// 从当前页面压入新的页面
  void didPushNext() {
    onPaused();
  }
}
