part of 'auth_bloc.dart';

sealed class AuthBlocEvent {
  const AuthBlocEvent();
}

final class AuthSignInWithEmailEvent extends AuthBlocEvent {
  const AuthSignInWithEmailEvent({required this.email, required this.password});
  final String email;
  final String password;
}

final class AuthSignUpWithEmailEvent extends AuthBlocEvent {
  const AuthSignUpWithEmailEvent({required this.email, required this.password});
  final String email;
  final String password;
}

final class NavigateToSignUpEvent extends AuthBlocEvent {
  const NavigateToSignUpEvent();
}

final class NavigateToSignInEvent extends AuthBlocEvent {
  const NavigateToSignInEvent();
}

final class NavigateToHomeScreenEvent extends AuthBlocEvent {
  const NavigateToHomeScreenEvent();
}

final class ClearErrorStateEvent extends AuthBlocEvent {
  const ClearErrorStateEvent();
}
