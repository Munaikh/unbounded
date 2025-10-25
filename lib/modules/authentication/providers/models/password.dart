class Password {
  final String _value;

  Password(String password) : _value = password.trim();

  void validate() {
    if (value.isEmpty) {
      throw const PasswordException("You must provide a password");
    }
    if (value.length < 5) {
      throw const PasswordException(
        "Your password must be at least 5 characters long",
      );
    }
  }

  String get value => _value;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Password &&
          runtimeType == other.runtimeType &&
          _value == other._value;

  @override
  int get hashCode => _value.hashCode;
}

class PasswordException implements Exception {
  final String message;

  const PasswordException(this.message);

  @override
  String toString() => message;
}
