import 'package:get_it/get_it.dart';
import 'package:muaho/common/extensions/network.dart';
import 'package:muaho/features/search/search_shop/bloc/search_shop_bloc.dart';

import 'data/repo/search_repository.dart';
import 'data/services/search_service.dart';
import 'domain/repo/search_repository.dart';
import 'domain/use_case/get_list_hot_search_use_case.dart';
import 'domain/use_case/search_by_category_use_case.dart';
import 'domain/use_case/search_by_keyword_use_case.dart';

void searchConfig(GetIt injector) {
  injector.registerLazySingleton<SearchService>(() => SearchService(
      injector(instanceName: DioInstanceType.DioTokenHandler.name)));
  injector.registerLazySingleton<SearchRepository>(
      () => SearchRepositoryImpl(searchService: injector()));
  injector
      .registerFactory(() => GetHotSearchUseCase(searchRepository: injector()));

  injector.registerFactory(
      () => SearchShopByKeywordUseCase(searchRepository: injector()));
  injector.registerFactory(
      () => SearchShopByCategoryUseCase(searchRepository: injector()));

  injector.registerFactory(
    () => SearchShopBloc(
        getListShopBySearchUseCase: injector(),
        getListShopByCategoryUseCase: injector()),
  );
}
