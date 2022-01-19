import 'package:get_it/get_it.dart';
import 'package:muaho/common/extensions/network.dart';
import 'package:muaho/features/home/presentation/history/complete/bloc/order_history_complete_bloc.dart';
import 'package:muaho/features/home/presentation/history/delivering/bloc/order_history_delivering_bloc.dart';
import 'package:muaho/features/home/presentation/history/history_order_detail/bloc/order_detail_bloc.dart';
import 'package:muaho/features/home/presentation/home_page/bloc/home_page_bloc.dart';
import 'package:muaho/features/home/presentation/setting_page/bloc/setting_bloc.dart';
import 'package:muaho/features/search/hot_search/bloc/hot_search_bloc.dart';

import 'data/repo/history/history_repository.dart';
import 'data/repo/home/home_repository.dart';
import 'data/services/history/history_service.dart';
import 'data/services/home_page/home_service.dart';
import 'domain/repo/history_page_repository.dart';
import 'domain/repo/home_page_repository.dart';
import 'domain/use_case/history/get_order_detail_use_case.dart';
import 'domain/use_case/history/get_order_history_complete_use_case.dart';
import 'domain/use_case/history/get_order_history_delivery_use_case.dart';
import 'domain/use_case/home/get_list_banner_use_case.dart';
import 'domain/use_case/home/get_list_product_categories_home_use_case.dart';

void homeConfig(GetIt injector) {
  injector.registerLazySingleton<HistoryService>(() => HistoryService(
      injector(instanceName: DioInstanceType.DioTokenHandler.name)));

  injector.registerLazySingleton<HomeService>(() => HomeService(
      injector(instanceName: DioInstanceType.DioTokenHandler.name)));

  injector.registerLazySingleton<HomePageRepository>(
      () => HomeRepositoryImpl(homeService: injector()));

  injector.registerFactory(
      () => GetListBannerUseCase(homePageRepository: injector()));

  injector.registerFactory(() =>
      GetListProductCategoriesHomeUseCase(homePageRepository: injector()));

  injector.registerFactory(
      () => GetOrderHistoryDeliveryUseCase(historyRepository: injector()));

  injector.registerFactory(
      () => GetOrderHistoryCompleteUseCase(historyPageRepository: injector()));

  injector.registerFactory(
      () => GetOrderDetailUseCase(historyPageRepository: injector()));

  injector.registerLazySingleton<HistoryPageRepository>(
    () => HistoryRepositoryImpl(service: injector()),
  );
  injector
      .registerFactory(() => HotSearchBloc(getHotSearchUseCase: injector()));

  injector.registerFactory(
    () => HomePageBloc(
      bannerUseCase: injector(),
      useCaseProductCategories: injector(),
      appEventBus: injector(),
      userStore: injector(),
      eventBus: injector(),
    ),
  );

  injector.registerFactory(
    () => OrderHistoryDeliveringBloc(
        getOrderHistoryDeliveryUseCase: injector(), appEventBus: injector()),
  );

  injector.registerFactory(() =>
      OrderHistoryCompleteBloc(getOrderHistoryCompleteUseCase: injector()));

  injector.registerFactory(
      () => OrderDetailBloc(getOrderDetailUseCase: injector()));

  injector.registerFactory(
    () => SettingBloc(
      userStore: injector(),
      appEventBus: injector(),
      firebaseAuth: injector(),
      currentMode: injector(),
    ),
  );
}
