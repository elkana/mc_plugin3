class PasswordChangeException implements Exception {
  String cause;
  PasswordChangeException(this.cause);
}

class CodeException implements Exception {
  String cause;
  int? code;
  CodeException(this.cause, [this.code]);

  @override
  String toString() => cause;
}
