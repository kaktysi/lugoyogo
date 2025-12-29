import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../domain/domain.dart';
import '../../../../../navigation/navigation.dart';

part 'auth_state.dart';
part 'auth_event.dart';

class AuthBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  final AppRouter _appRouter;
  final SignUpWithEmailUseCase _signUpWithEmailUseCase;
  final SignInWithEmailUseCase _signInWithEmailUseCase;

  AuthBloc({
    required AppRouter appRouter,
    required SignUpWithEmailUseCase signUpWithEmailUseCase,
    required SignInWithEmailUseCase signInWithEmailUseCase,
  }) : _appRouter = appRouter,
       _signUpWithEmailUseCase = signUpWithEmailUseCase,
       _signInWithEmailUseCase = signInWithEmailUseCase,
       super(const AuthBlocState.initial()) {
    on<AuthSignInWithEmailEvent>(_onAuthSignInWithEmailEvent);
    on<AuthSignUpWithEmailEvent>(_onAuthSignUpWithEmailEvent);
    on<NavigateToSignInEvent>(_onNavigateToSignInEvent);
    on<NavigateToSignUpEvent>(_onNavigateToSignUpEvent);
    on<NavigateToHomeScreenEvent>(_onNavigateToHomeScreenEvent);
    on<ClearErrorStateEvent>(_onClearErrorStateEvent);
  }

  FutureOr<void> _onAuthSignInWithEmailEvent(
    AuthSignInWithEmailEvent event,
    Emitter<AuthBlocState> emit,
  ) async {
    try {
      if (!_isLoginValid(event.email)) {
        emit(state.copyWith(isLoginInvalid: true));
        return;
      }
      if (!_isPasswordValid(event.password)) {
        emit(state.copyWith(isPasswordInvalid: true));
        return;
      }
      emit(state.copyWith(isLoading: true));
      await _signInWithEmailUseCase.execute(
        email: event.email,
        password: event.password,
      );
      emit(state.copyWith(isSuccessful: true));
    } catch (e) {
      emit(state.copyWith(invalidCredentials: true));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  FutureOr<void> _onAuthSignUpWithEmailEvent(
    AuthSignUpWithEmailEvent event,
    Emitter<AuthBlocState> emit,
  ) async {
    try {
      if (!_isLoginValid(event.email)) {
        emit(state.copyWith(isLoginInvalid: true));
        return;
      }
      if (!_isPasswordValid(event.password)) {
        emit(state.copyWith(isPasswordInvalid: true));
        return;
      }
      emit(state.copyWith(isLoading: true));
      await _signUpWithEmailUseCase.execute(
        email: event.email,
        password: event.password,
      );
      emit(state.copyWith(isSuccessful: true));
    } catch (e) {
      emit(state.copyWith(invalidCredentials: true));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  FutureOr<void> _onNavigateToSignInEvent(
    NavigateToSignInEvent event,
    Emitter<AuthBlocState> emit,
  ) async {
    await _appRouter.replace(const SignInRoute());
  }

  FutureOr<void> _onNavigateToSignUpEvent(
    NavigateToSignUpEvent event,
    Emitter<AuthBlocState> emit,
  ) async {
    await _appRouter.replace(const SignUpRoute());
  }

  FutureOr<void> _onNavigateToHomeScreenEvent(
    NavigateToHomeScreenEvent event,
    Emitter<AuthBlocState> emit,
  ) async {
    await _appRouter.replace(const HomeRoute());
  }

  FutureOr<void> _onClearErrorStateEvent(
    ClearErrorStateEvent event,
    Emitter<AuthBlocState> emit,
  ) {
    emit(
      state.copyWith(
        isLoginInvalid: false,
        isPasswordInvalid: false,
        invalidCredentials: false,
      ),
    );
  }

  bool _isLoginValid(String email) {
    return RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(email);
  }

  bool _isPasswordValid(String password) {
    if (password.length < 8 || password.length > 20) return false;
    return true;
  }
}
