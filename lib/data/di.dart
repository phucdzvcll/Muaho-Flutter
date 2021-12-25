import 'package:get_it/get_it.dart';
import 'package:muaho/common/common.dart';
import 'package:muaho/domain/domain.dart';

import 'data.dart';

void dataDiConfig(GetIt injector) {
  //homePage
  injector.registerLazySingleton<HomeService>(() => HomeService(
      injector(instanceName: DioInstanceType.DioTokenHandler.name)));
  injector.registerLazySingleton<HomePageRepository>(
      () => HomeRepositoryImpl(homeService: injector()));
  //searchPage
  injector.registerLazySingleton<SearchService>(() => SearchService(
      injector(instanceName: DioInstanceType.DioTokenHandler.name)));
  injector.registerLazySingleton<SearchRepository>(
      () => SearchRepositoryImpl(searchService: injector()));
  //signIn
  injector.registerLazySingleton<SignInService>(
      () => SignInService(injector(instanceName: DioInstanceType.Dio.name)));
  injector.registerLazySingleton<SignInRepository>(() => SignInRepositoryImpl(
        service: injector(),
        userStore: injector(),
      ));
  //shop
  injector.registerLazySingleton<ShopService>(() => ShopService(
      injector(instanceName: DioInstanceType.DioTokenHandler.name)));
  injector.registerLazySingleton<ShopRepository>(
      () => ShopRepositoryImpl(service: injector()));
  //history
  injector.registerLazySingleton<HistoryService>(() => HistoryService(
      injector(instanceName: DioInstanceType.DioTokenHandler.name)));
  injector.registerLazySingleton<HistoryPageRepository>(
      () => HistoryRepositoryImpl(service: injector()));
  //oder
  injector.registerLazySingleton<OrderService>(() => OrderService(
      injector(instanceName: DioInstanceType.DioTokenHandler.name)));
  injector.registerLazySingleton<CreateOrderRepository>(
      () => OrderRepositoryImpl(service: injector()));
}
