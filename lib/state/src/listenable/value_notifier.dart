import 'dart:collection';

import 'package:yuro/util/util.dart';

import 'listen_notifier.dart';

part 'notifier/list_notifier.dart';

part 'notifier/map_notifier.dart';

part 'notifier/object_notifier.dart';

part 'notifier/set_notifier.dart';

abstract class ValueNotifier<T> extends ListenNotifier {
  T get value;
}
