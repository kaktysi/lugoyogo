import 'package:get_it/get_it.dart';

import '../../../data/data.dart';
import '../../../domain/domain.dart';
import '../../../navigation/src/app_router/app_router.dart';

final GetIt appLocator = GetIt.instance;

class AppDI {
  static void _initProviders(GetIt locator) {
    locator.registerLazySingleton<AuthenticationProvider>(
      AuthenticationFirebaseProviderImpl.new,
    );
  }

  static void _initRepositories(GetIt locator) {
    locator.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        authProviderImpl:
            locator<AuthenticationProvider>()
                as AuthenticationFirebaseProviderImpl,
        errorHandler: locator<AppErrorHandler>(),
      ),
    );
  }

  static void _initExceptionHandlers(GetIt locator) {
    locator.registerLazySingleton<AppErrorHandler>(AppErrorHandler.new);
  }

  static void _initUseCases(GetIt locator) {
    locator.registerFactory<SignInWithEmailUseCase>(
      () => SignInWithEmailUseCase(authRepository: locator<AuthRepository>()),
    );
    locator.registerFactory<SignUpWithEmailUseCase>(
      () => SignUpWithEmailUseCase(authRepository: locator<AuthRepository>()),
    );
  }

  static void _initRouters(GetIt locator) {
    locator.registerLazySingleton<AppRouter>(AppRouter.new);
  }

  static void initDependencies(GetIt locator) {
    _initRouters(locator);
    _initExceptionHandlers(locator);
    _initProviders(locator);
    _initRepositories(locator);
    _initUseCases(locator);
  }
}
