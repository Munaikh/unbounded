import 'package:dio/dio.dart';

/// Your backend should return a json with the following structure:
/// {
///  "code": "string",
///  "message": "string"
/// }
class ApiError implements Exception {
  final int? code;
  final String? message;

  ApiError({
    this.code,
    this.message,
  });

  factory ApiError.fromDioException(DioException e) {
    return ApiError(
      code: e.response?.statusCode ?? 0,
      message: e.message,
    );
  }

  @override
  String toString() {
    return 'ApiError(code: $code, message: $message)';
  }
}
