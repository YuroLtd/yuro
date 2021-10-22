import 'package:uuid/uuid.dart';

extension UUIDExt on String {
  String uuid5() => Uuid().v5(Uuid.NAMESPACE_OID, this);

  //todo 不全其它uuid方法
}
