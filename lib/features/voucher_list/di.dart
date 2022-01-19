import 'package:get_it/get_it.dart';
import 'package:muaho/common/extensions/network.dart';
import 'package:muaho/features/voucher_list/presentaition/bloc/voucher_list_bloc.dart';

import 'data/repo/user_repository.dart';
import 'data/services/user_service.dart';
import 'domain/repo/user_repository.dart';
import 'domain/use_case/get_voucher_list_use_case.dart';

void userConfig(GetIt injector) {
  injector.registerFactory(
    () => UserService(
      injector(instanceName: DioInstanceType.DioTokenHandler.name),
    ),
  );
  injector.registerFactory<UserRepository>(
    () => UserRepositoryImpl(
      userService: injector(),
    ),
  );
  injector.registerFactory(() => GetVoucherListUseCase(
        userRepository: injector(),
      ));
  injector.registerFactory(
    () => VoucherListBloc(
      getVoucherListUseCase: injector(),
    ),
  );
}
