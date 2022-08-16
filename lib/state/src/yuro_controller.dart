import 'package:flutter/widgets.dart';
import 'package:yuro/core/core.dart';
import 'listenable/listen_notifier.dart';

import 'controller_mixin/lifecycle_mixin.dart';

abstract class YuroController extends ListenNotifier with YuroLifeCycleMixin {}

abstract class LifeCycleController extends YuroController with WidgetsBindingObserver {}

class AppLifeCycleController extends LifeCycleController with LifeCycleControllerMixin {}
