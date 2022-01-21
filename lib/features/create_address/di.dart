import 'package:get_it/get_it.dart';
import 'package:muaho/common/extensions/network.dart';
import 'package:muaho/features/create_address/data/repo/create_address_repository_impl.dart';
import 'package:muaho/features/create_address/data/services/create_address_service.dart';
import 'package:muaho/features/create_address/domain/repo/create_address_repository.dart';
import 'package:muaho/features/create_address/presentation/bloc/create_address_bloc.dart';

import 'domain/use_case/create_address_use_case.dart';

void createAddressConfig(GetIt injector) {
  injector.registerLazySingleton(
    () => CreateAddressService(
      injector(instanceName: DioInstanceType.DioTokenHandler.name),
    ),
  );

  injector.registerFactory<CreateAddressRepository>(
      () => CreateAddressInfoRepositoryImpl(service: injector()));

  injector.registerFactory(() => CreateAddressUseCase(
        createAddressRepository: injector(),
      ));
  injector.registerFactory<CreateAddressBloc>(() => CreateAddressBloc(
        appGeoLocator: injector(),
        createAddressUseCase: injector(),
      ));
}
