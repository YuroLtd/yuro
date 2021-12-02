import 'level.dart';

/// 日志输出事件
class OutputEvent {
  final LogLevel level;

  final List<String> lines;

  OutputEvent(this.level, this.lines);
}
/// 日志输出
abstract class LogOutput {
  void output(OutputEvent event);
}

/// 日志输出到控制台
class ConsoleOutput extends LogOutput {
  @override
  void output(OutputEvent event) => event.lines.forEach(print);
}
