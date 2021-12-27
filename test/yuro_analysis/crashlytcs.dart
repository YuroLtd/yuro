import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yuro/yuro_analysis/crashlytics/crashlytics.dart';

void main() {
  test('Crashlytics', () {
    runZonedGuarded(() {
      // Future.error(const FormatException('1'), StackTrace.current);
      TT().tesst();
    }, (err, stack) {
      YuroCrashlytics.instance.recordError(err, stack);
    });
  });


}

class TT{
  void tesst(){
    throw FlutterError.fromParts(<DiagnosticsNode>[
      ErrorSummary('setState() called after dispose(): $this'),
      ErrorDescription(
        'This error happens if you call setState() on a State object for a widget that '
            'no longer appears in the widget tree (e.g., whose parent widget no longer '
            'includes the widget in its build). This error can occur when code calls '
            'setState() from a timer or an animation callback.',
      ),
      ErrorHint(
        'The preferred solution is '
            'to cancel the timer or stop listening to the animation in the dispose() '
            'callback. Another solution is to check the "mounted" property of this '
            'object before calling setState() to ensure the object is still in the '
            'tree.',
      ),
      ErrorHint(
        'This error might indicate a memory leak if setState() is being called '
            'because another object is retaining a reference to this State object '
            'after it has been removed from the tree. To avoid memory leaks, '
            'consider breaking the reference to this object during dispose().',
      ),
    ]);
  }
}
