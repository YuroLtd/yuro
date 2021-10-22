import 'package:yuro/yuro_logger/src/log_level.dart';
import 'dart:developer' as developer;

class OutputEvent {
  final LogLevel level;

  final List<String> lines;

  OutputEvent(this.level, this.lines);
}

abstract class LogOutput {
  void output(OutputEvent event);
}

class ConsoleOutput extends LogOutput {
  @override
  void output(OutputEvent event) {
    event.lines.forEach(print);

  }
}
