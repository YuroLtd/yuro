
import 'package:path/path.dart' as path;

extension PathForStringExt on String {
  String join(String dir) => path.join(this, dir);
}
