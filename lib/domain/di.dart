import 'package:get_it/get_it.dart';

import 'domain.dart';

void domainDiConfig(GetIt injector) {
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

  injector
      .registerFactory(() => GetListAddressInfoUseCase(repository: injector()));
}
