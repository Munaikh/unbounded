class Email {
  final String _value;

  Email(String email) : _value = email.trim();

  void validate() {
    const pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    final regex = RegExp(pattern);
    final isValidateEmail = regex.hasMatch(value);
    if (!isValidateEmail) {
      throw const EmailException("Email not valid");
    }
  }

  String get value => _value;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Email &&
          runtimeType == other.runtimeType &&
          _value == other._value;

  @override
  int get hashCode => _value.hashCode;
}

class EmailException implements Exception {
  final String message;

  const EmailException(this.message);

  @override
  String toString() => message;
}
