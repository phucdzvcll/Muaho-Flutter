import 'package:get_it/get_it.dart';
import 'package:muaho/common/extensions/network.dart';
import 'package:muaho/features/cart_update_bloc/cart_update_bloc.dart';
import 'package:muaho/features/payment/presentation/bloc/payment_bloc.dart';

import 'data/repo/order_repository.dart';
import 'data/services/order_service.dart';
import 'domain/repo/create_order_repository.dart';
import 'domain/use_case/create_order_use_case.dart';

void paymentConfig(GetIt injector) {
  injector.registerLazySingleton<OrderService>(() => OrderService(
      injector(instanceName: DioInstanceType.DioTokenHandler.name)));

  injector.registerLazySingleton<CreateOrderRepository>(
    () => OrderRepositoryImpl(
      service: injector(),
    ),
  );

  injector.registerFactory(
      () => CreateOrderUseCase(createOrderRepository: injector()));

  injector.registerFactoryParam<PaymentBloc, CartUpdateBloc, void>(
    (cartUpdateBloc, _) => PaymentBloc(
      firebaseAuth: injector(),
      cartUpdateBloc: cartUpdateBloc,
      createOrderUseCase: injector(),
      appEventBus: injector(),
    ),
  );
}
