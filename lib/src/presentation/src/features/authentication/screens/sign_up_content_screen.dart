import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../domain/domain.dart';
import '../../../theme/theme.dart';
import '../../../utils/utils.dart';
import '../authentication.dart';

class SignUpContentScreen extends StatefulWidget {
  const SignUpContentScreen({super.key});

  @override
  State<SignUpContentScreen> createState() => _SignUpContentScreenState();
}

class _SignUpContentScreenState extends State<SignUpContentScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: AppDimens.WIDTH_400),
          padding: const EdgeInsets.all(AppDimens.PADDING_16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: AppDimens.SPACING_10,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  label: const Text('email'),
                  hintText: 'Enter your email please',
                  prefixIcon: const Icon(Icons.email_outlined),
                  border: const OutlineInputBorder(),
                  errorText: _emailController.text.isEmpty
                      ? 'This field is required'
                      : null,
                ),
                onChanged: (_) => setState(() {}),
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
              ),
              TextField(
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  label: const Text('password'),
                  hintText: 'Enter your password please',
                  prefixIcon: const Icon(Icons.password_outlined),
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: _obscurePassword
                        ? const Icon(Icons.visibility_off)
                        : const Icon(Icons.remove_red_eye_outlined),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                  errorText: _passwordController.text.isEmpty
                      ? 'This field is required'
                      : null,
                ),
                onChanged: (_) => setState(() {}),
                controller: _passwordController,
              ),
              SizedBox(
                width: AppDimens.WIDTH_INFINITY,
                child: BlocConsumer<AuthBloc, AuthBlocState>(
                  listenWhen:
                      (AuthBlocState prevState, AuthBlocState currState) =>
                          prevState.invalidCredentials !=
                              currState.invalidCredentials ||
                          prevState.isLoginInvalid !=
                              currState.isLoginInvalid ||
                          prevState.isPasswordInvalid !=
                              currState.isPasswordInvalid ||
                          prevState.isSuccessful != currState.isSuccessful,
                  listener: (BuildContext context, AuthBlocState state) {
                    if (state.invalidCredentials) {
                      context.showSnackBar(
                        'Invalid credentials, please try again.',
                      );
                    }
                    if (state.isLoginInvalid) {
                      context.showSnackBar('Invalid email, please try again.');
                    }
                    if (state.isPasswordInvalid) {
                      context.showSnackBar(
                        'Invalid password, please try again.',
                      );
                    }
                    if (state.isSuccessful) {
                      context.showSnackBar(
                        'Sign up successful! Please sign in.',
                        type: SnackBarTypeEnum.success,
                      );
                      context.read<AuthBloc>().add(
                        const NavigateToSignInEvent(),
                      );
                    }
                    context.read<AuthBloc>().add(const ClearErrorStateEvent());
                  },
                  builder: (BuildContext context, AuthBlocState state) {
                    return FilledButton(
                      onPressed: () {
                        context.read<AuthBloc>().add(
                          AuthSignUpWithEmailEvent(
                            email: _emailController.text,
                            password: _passwordController.text,
                          ),
                        );
                      },
                      child: Text(
                        state.isLoading ? 'Loading...' : 'Sign up',
                        style: AppFonts.bold14,
                      ),
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text('Already have an account?'),
                  TextButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(
                        const NavigateToSignInEvent(),
                      );
                    },
                    child: Text('Sign in', style: AppFonts.bold14),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
