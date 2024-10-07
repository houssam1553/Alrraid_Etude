import 'package:arraid/models/userModel.dart';
import 'package:arraid/services/apiService.dart';

class AuthException implements Exception {
  final String message;
  final int? statusCode;

  AuthException(this.message, this.statusCode);

  @override
  String toString() => 'AuthException: $message (Status code: $statusCode)';
}

