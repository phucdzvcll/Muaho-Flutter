import 'package:get_it/get_it.dart';
import 'package:muaho/common/extensions/network.dart';
import 'package:muaho/features/change_display_name/presentation/bloc/change_display_name_bloc.dart';

import 'data/repo/setting_repository_impl.dart';
import 'data/service/change_display_name_service.dart';
import 'domain/repo/change_name_page_repository.dart';
import 'domain/use_case/change_display_name_use_case.dart';

void changeDisplayNameConfig(GetIt injector) {
  injector.registerLazySingleton(() => ChangeDisplayNameService(
      injector(instanceName: DioInstanceType.DioTokenHandler.name)));
  injector.registerFactory<ChangeNameRepository>(
    () => ChangeNameRepositoryImpl(
      service: injector(),
      userStore: injector(),
    ),
  );

  injector.registerFactory(
    () => ChangeDisplayNameUseCase(
      settingPageRepository: injector(),
    ),
  );

  injector.registerFactory(
    () => ChangeDisplayNameBloc(
      changeDisplayNameUseCase: injector(),
      appEventBus: injector(),
    ),
  );
}
