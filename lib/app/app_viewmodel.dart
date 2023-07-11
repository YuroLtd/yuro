import 'package:flutter/cupertino.dart';
import 'package:yuro/state/viewmodel.dart';

abstract class RootViewModel extends BaseViewModel {
  RootViewModel(super.context);

  UniqueKey? appKey;
}

class MaterialViewModel extends RootViewModel {
  MaterialViewModel(super.context);
}

class CupertinoViewModel extends RootViewModel {
  CupertinoViewModel(super.context);

  CupertinoThemeData? theme;
}
