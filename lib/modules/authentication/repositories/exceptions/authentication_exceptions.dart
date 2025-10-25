import 'package:apparence_kit/core/data/api/base_api_exceptions.dart';

class SignupException {
  final int? code;
  final String? message;

  SignupException({
    this.code,
    this.message,
  });

  factory SignupException.fromApiError(ApiError error) {
    return SignupException(
      code: error.code,
      message: error.message,
    );
  }

  @override
  String toString() {
    return 'SignupException(code: $code, message: $message)';
  }
}

class SigninException {
  final int? code;
  final String? message;

  SigninException({
    this.code,
    this.message,
  });

  factory SigninException.fromApiError(ApiError error) {
    return SigninException(
      code: error.code,
      message: error.message,
    );
  }

  @override
  String toString() {
    return 'SigninException(code: $code, message: $message)';
  }
}

class RecoverPasswordException {
  final int? code;
  final String? message;

  RecoverPasswordException({
    this.code,
    this.message,
  });

  factory RecoverPasswordException.fromApiError(ApiError error) {
    return RecoverPasswordException(
      code: error.code,
      message: error.message,
    );
  }

  @override
  String toString() {
    return 'SigninException(code: $code, message: $message)';
  }
}

class PhoneAuthException extends ApiError {
  PhoneAuthException({
    required super.code,
    required super.message,
  });

  factory PhoneAuthException.fromApiError(ApiError error) {
    return PhoneAuthException(
      code: error.code,
      message: error.message,
    );
  }
}