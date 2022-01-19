import 'package:get_it/get_it.dart';
import 'package:muaho/features/register/data/repo/registe_repository_impl.dart';
import 'package:muaho/features/register/domain/repo/register_repository.dart';

import 'bloc/register_bloc.dart';
import 'domain/use_case/register_email_use_case.dart';

void registerConfig(GetIt injector) {
  injector.registerFactory<RegisterRepository>(
    () => RegisterRepositoryImpl(
      service: injector(),
      userStore: injector(),
      firebaseAuth: injector(),
    ),
  );

  injector.registerFactory(() => RegisterEmailUseCase(
        registerRepository: injector(),
      ));

  injector.registerFactory(
    () => RegisterBloc(
      registerEmailUseCase: injector(),
      appEventBus: injector(),
    ),
  );
}
