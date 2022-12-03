import 'package:yuro/core/core.dart';

import 'listenable/listen_notifier.dart';

abstract class YuroController extends ListenNotifier with YuroLifeCycleMixin {}
