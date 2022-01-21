import 'package:get_it/get_it.dart';
import 'package:muaho/features/login/data/repo/login_repository_impl.dart';
import 'package:muaho/features/login/domain/repo/login_repository.dart';
import 'package:muaho/features/login/presentation/bloc/login_bloc.dart';

import 'domain/use_case/login_email_use_case.dart';

void loginConfig(GetIt injector) {
  injector.registerLazySingleton<LoginRepository>(() => LoginRepositoryImpl(
        service: injector(),
        userStore: injector(),
        firebaseAuth: injector(),
      ));

  injector.registerFactory(() => LoginEmailUseCase(
        loginRepository: injector(),
      ));
  injector.registerFactory(
    () => LoginBloc(
      loginEmailUseCase: injector(),
      appEventBus: injector(),
    ),
  );
}
