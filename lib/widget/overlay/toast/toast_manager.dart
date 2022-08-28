part of 'toast.dart';

class ToastManager{
  ToastTheme theme = ToastTheme();

  void show(){

  }

}


// class _ToastFuture {
//   _ToastFuture(this.entry, this.onDismiss, this.containerKey, this.animationDuration);
//
//   final OverlayEntry entry;
//   final VoidCallback? onDismiss;
//   final GlobalKey<_ToastContainerState> containerKey;
//   final Duration animationDuration;
//
//   Timer? timer;
//
//   void dismiss([bool anim = true]) {
//     if (anim) {
//       containerKey.currentState?.dismiss();
//       Future.delayed(animationDuration, entry.remove);
//     } else {
//       entry.remove();
//     }
//     timer?.cancel();
//     _ToastManager().remove(this);
//     onDismiss?.call();
//   }
// }