class IllagalArgumentError extends Error {
  final String? name;
  final dynamic message;

  IllagalArgumentError(this.name, [this.message]);

  @override
  String toString() {
    final nameString = (name == null) ? "" : " ($name)";
    final messageString = (message == null) ? "" : ": ${Error.safeToString(message)}";
    return "Missing parameters$nameString$messageString.";
  }
}
