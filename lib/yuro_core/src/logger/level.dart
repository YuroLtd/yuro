enum LogLevel { verbose, debug, info, warring, error }

extension LogLevelExt on LogLevel {
  String get str {
    switch (this) {
      case LogLevel.verbose:
        return 'VERBOSE';
      case LogLevel.debug:
        return 'DEBUG';
      case LogLevel.info:
        return 'INFO';
      case LogLevel.warring:
        return 'WARRING';
      case LogLevel.error:
        return 'ERROR';
    }
  }

  String get simpleStr {
    switch (this) {
      case LogLevel.verbose:
        return 'V';
      case LogLevel.debug:
        return 'D';
      case LogLevel.info:
        return 'I';
      case LogLevel.warring:
        return 'W';
      case LogLevel.error:
        return 'E';
    }
  }
}
