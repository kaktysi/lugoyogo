part of 'auth_bloc.dart';

class AuthBlocState {
  final bool isLoginInvalid;
  final bool isPasswordInvalid;
  final bool invalidCredentials;
  final bool isSuccessful;
  final bool isLoading;

  const AuthBlocState({
    required this.isLoginInvalid,
    required this.isPasswordInvalid,
    required this.invalidCredentials,
    required this.isSuccessful,
    required this.isLoading,
  });

  const AuthBlocState.initial()
    : isLoginInvalid = false,
      isPasswordInvalid = false,
      invalidCredentials = false,
      isSuccessful = false,
      isLoading = false;

  AuthBlocState copyWith({
    bool? isLoginInvalid,
    bool? isPasswordInvalid,
    bool? invalidCredentials,
    bool? isSuccessful,
    bool? isLoading,
  }) {
    return AuthBlocState(
      isLoginInvalid: isLoginInvalid ?? this.isLoginInvalid,
      isPasswordInvalid: isPasswordInvalid ?? this.isPasswordInvalid,
      invalidCredentials: invalidCredentials ?? this.invalidCredentials,
      isSuccessful: isSuccessful ?? this.isSuccessful,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
