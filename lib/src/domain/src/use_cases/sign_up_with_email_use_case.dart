import '../../domain.dart';

class SignUpWithEmailUseCase {
  final AuthRepository _authRepository;

  SignUpWithEmailUseCase({required AuthRepository authRepository})
    : _authRepository = authRepository;

  Future<void> execute({
    required String email,
    required String password,
  }) async {
    await _authRepository.signUpWithEmail(email, password);
  }
}
