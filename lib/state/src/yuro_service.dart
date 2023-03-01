import 'package:yuro/core/src/lifecycle.dart';

mixin YuroServiceMixin {}

abstract class YuroService with YuroLifeCycleMixin, YuroServiceMixin {}
