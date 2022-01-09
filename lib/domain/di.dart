import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:muaho/domain/use_case/address/create_address_use_case.dart';
import 'package:muaho/domain/use_case/voucher/get_voucher_list_use_case.dart';

import 'domain.dart';

void domainDiConfig(GetIt injector) {
  injector.registerLazySingleton(() => FirebaseAuth.instance);

  injector.registerFactory(
      () => GetListBannerUseCase(homePageRepository: injector()));

  injector.registerFactory(() =>
      GetListProductCategoriesHomeUseCase(homePageRepository: injector()));

  injector
      .registerFactory(() => GetHotSearchUseCase(searchRepository: injector()));

  injector.registerFactory(
      () => GetListShopBySearchUseCase(searchRepository: injector()));

  injector.registerFactory(() => SignInUseCase(signInRepository: injector()));

  injector
      .registerFactory(() => GetShopProductUseCase(shopRepository: injector()));

  injector.registerFactory(
      () => GetOrderHistoryDeliveryUseCase(historyRepository: injector()));

  injector.registerFactory(
      () => GetOrderHistoryCompleteUseCase(historyPageRepository: injector()));

  injector.registerFactory(
      () => GetOrderDetailUseCase(historyPageRepository: injector()));

  injector.registerFactory(
      () => CreateOrderUseCase(createOrderRepository: injector()));

  injector.registerFactory(() => CreateAddressUseCase(
        addressInfoRepository: injector(),
      ));

  injector
      .registerFactory(() => GetListAddressInfoUseCase(repository: injector()));

  injector.registerFactory(() => LoginEmailUseCase(
        signInRepository: injector(),
      ));
  injector.registerFactory(() => GetVoucherListUseCase(
      userRepository: injector(),
  ));
}
