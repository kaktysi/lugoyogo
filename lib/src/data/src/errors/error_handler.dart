import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../domain/domain.dart';

class AppErrorHandler {
  Never handleDioError(DioException error) {
    final Response<dynamic>? response = error.response;

    if (error.type == DioExceptionType.connectionError) {
      throw const AppException('no connection');
    }

    final dynamic message = response?.data['message'];

    final int? statusCode = response?.statusCode;
    switch (statusCode) {
      case 400:
        throw AppException(message ?? 'Bad request (400)');
      case 401:
        throw AppException(message ?? 'Unauthorized (401)');
      case 403:
        throw AppException(message ?? 'Forbidden (403)');
      case 404:
        throw AppException(message ?? 'Not found (404)');
      case 405:
        throw AppException(message ?? 'Method not allowed (405)');
      case 408:
        throw AppException(message ?? 'Request timeout (408)');
      case 429:
        throw AppException(message ?? 'Too many requests (429)');
      case 500:
        throw AppException(message ?? 'Internal server error (500)');
      case 502:
        throw AppException(message ?? 'Bad gateway (502)');
      case 503:
        throw AppException(message ?? 'Service unavailable (503)');
      case 504:
        throw AppException(message ?? 'Gateway timeout (504)');
      default:
        throw AppException('Error $statusCode: ${message ?? 'Unknown error'}');
    }
  }

  Never handleFirebaseAuthError(FirebaseAuthException error) {
    switch (error.code) {
      case 'user-not-found':
        throw const AppException('No user found for that email.');
      case 'wrong-password':
        throw const AppException('Wrong password provided for that user.');
      case 'weak-password':
        throw const AppException('The password provided is too weak.');
      case 'email-already-in-use':
        throw const AppException('The account already exists for that email.');
      default:
        throw AppException('Firebase Auth Error: ${error.message}');
    }
  }

  Never handleUnknownError(dynamic error) {
    throw AppException('Unknown error: ${error.message}');
  }

  Never handleAppExceptionError(AppException error) {
    throw AppException('App Exception: ${error.message}');
  }
}
