import 'package:get_it/get_it.dart';
import 'package:muaho/common/extensions/network.dart';

import 'bloc/sign_bloc_bloc.dart';
import 'data/repo/sign_in_repository.dart';
import 'data/services/sign_in_service.dart';
import 'domain/repo/sign_in_repository.dart';
import 'domain/use_case/get_jwt_token_use_case.dart';

void signInConfig(GetIt injector) {
  injector.registerLazySingleton<SignInService>(
      () => SignInService(injector(instanceName: DioInstanceType.Dio.name)));
  injector.registerLazySingleton<SignInRepository>(() => SignInRepositoryImpl(
        service: injector(),
        userStore: injector(),
        firebaseAuth: injector(),
      ));
  injector.registerFactory(() => SignInUseCase(signInRepository: injector()));

  injector.registerFactory(
    () => SignBloc(
      signInUseCase: injector(),
    ),
  );
}
