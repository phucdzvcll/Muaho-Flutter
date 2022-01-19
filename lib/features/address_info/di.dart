import 'package:get_it/get_it.dart';
import 'package:muaho/common/extensions/network.dart';
import 'package:muaho/features/address_info/data/services/address_service.dart';
import 'package:muaho/features/address_info/presentation/bloc/address_bloc.dart';

import 'data/repo/address_info_repository.dart';
import 'domain/repo/address_infor_repository.dart';
import 'domain/use_case/get_list_address_info_use_case.dart';

void addressInfoConfig(GetIt injector) {
  injector.registerLazySingleton(() => AddressService(
      injector(instanceName: DioInstanceType.DioTokenHandler.name)));

  injector.registerLazySingleton<AddressRepository>(
      () => AddressInfoRepositoryImpl(service: injector()));

  injector
      .registerFactory(() => GetListAddressInfoUseCase(repository: injector()));

  injector.registerFactory(() => AddressBloc(
        getListAddressInfoUseCase: injector(),
      ));
}
