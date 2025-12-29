import 'package:firebase_auth/firebase_auth.dart';

import '../../../domain/domain.dart';
import '../../data.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthenticationFirebaseProviderImpl _authProviderImpl;
  final AppErrorHandler _errorHandler;

  AuthRepositoryImpl({
    required AuthenticationFirebaseProviderImpl authProviderImpl,
    required AppErrorHandler errorHandler,
  }) : _authProviderImpl = authProviderImpl,
       _errorHandler = errorHandler;

  @override
  Future<void> signInWithEmail(String email, String password) async {
    try {
      await _authProviderImpl.signInWithEmail(email, password);
    } on FirebaseAuthException catch (e) {
      _errorHandler.handleFirebaseAuthError(e);
    } on AppException catch (e) {
      _errorHandler.handleAppExceptionError(e);
    } catch (e) {
      _errorHandler.handleUnknownError(e);
    }
  }

  @override
  Future<void> signUpWithEmail(String email, String password) async {
    try {
      await _authProviderImpl.signUpWithEmail(email, password);
    } on FirebaseAuthException catch (e) {
      _errorHandler.handleFirebaseAuthError(e);
    } on AppException catch (e) {
      _errorHandler.handleAppExceptionError(e);
    } catch (e) {
      _errorHandler.handleUnknownError(e);
    }
  }
}
