import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/core.dart';
import '../../../../../domain/domain.dart';
import '../../../../../navigation/navigation.dart';
import '../authentication.dart';

@RoutePage()
class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (_) => AuthBloc(
        appRouter: appLocator<AppRouter>(),
        signUpWithEmailUseCase: appLocator<SignUpWithEmailUseCase>(),
        signInWithEmailUseCase: appLocator<SignInWithEmailUseCase>(),
      ),
      child: const SignInContentScreen(),
    );
  }
}
