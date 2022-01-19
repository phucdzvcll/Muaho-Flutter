import 'package:get_it/get_it.dart';
import 'package:muaho/common/extensions/network.dart';
import 'package:muaho/features/cart_update_bloc/cart_update_bloc.dart';
import 'package:muaho/features/order/presentation/bloc/order_bloc.dart';

import 'data/repo/shop_repository.dart';
import 'data/services/shop_service.dart';
import 'domain/repo/shop_repository.dart';
import 'domain/use_case/get_shop_product_use_case.dart';

void shopProductConfig(GetIt injector) {
  injector.registerLazySingleton<ShopService>(() => ShopService(
      injector(instanceName: DioInstanceType.DioTokenHandler.name)));
  injector.registerLazySingleton<ShopRepository>(
      () => ShopRepositoryImpl(service: injector()));
  injector
      .registerFactory(() => GetShopProductUseCase(shopRepository: injector()));

  injector.registerFactoryParam<OrderBloc, CartUpdateBloc, void>(
      (cartUpdateBloc, _) => OrderBloc(
          getShopProductUseCase: injector(), cartUpdateBloc: cartUpdateBloc));
}
