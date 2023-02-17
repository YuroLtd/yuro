part of '../yuro_controller.dart';

mixin StreamMixin on YuroController {
  late final StreamSubscription _subscription;

  List<int> get events;

  @override
  void onInit() {
    super.onInit();
    _subscription = Yuro.stream<Event>().where((event) => events.contains(event.code)).listen(handlerEvent);
  }

  void handlerEvent(Event event);

  @override
  void onDispose() {
    _subscription.cancel();
    super.onDispose();
  }
}
