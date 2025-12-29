import '../../domain.dart';

class SignInWithEmailUseCase {
  final AuthRepository _authRepository;

  SignInWithEmailUseCase({required AuthRepository authRepository})
    : _authRepository = authRepository;
    
  Future<void> execute({
    required String email,
    required String password,
  }) async {
    await _authRepository.signInWithEmail(email, password);
  }
}
