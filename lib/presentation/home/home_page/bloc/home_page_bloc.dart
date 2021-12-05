import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:muaho/domain/domain.dart';
import 'package:muaho/presentation/home/home_page/model/home_page_model.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc() : super(HomePageInitial());
  final GetListProductCategoriesHomeUseCase _useCaseProductCategories =
      GetIt.instance.get();
  final GetListBannerUseCase _bannerUseCase = GetIt.instance.get();

  List<ProductCategoryHomeEntity> _productCategories = [];
  List<SlideBannerEntity> _slideBannerEntity = [];

  @override
  Stream<HomePageState> mapEventToState(HomePageEvent event) async* {
    if (event is HomePageRequestEvent) {
      yield* _handleHomePageRequestEvent();
    }
  }

  Stream<HomePageState> _handleHomePageRequestEvent() async* {
    yield HomePageLoading();

    Either<Failure, ProductCategoriesHomeResults> productCategoriesResult =
        await _useCaseProductCategories.execute(EmptyInput());

    Either<Failure, BannersResult> bannersResult =
        await _bannerUseCase.execute(EmptyInput());
    _productCategories.clear();
    _slideBannerEntity.clear();
    if (productCategoriesResult.isSuccess) {
      _productCategories
          .addAll(productCategoriesResult.success.listProductCategory);
    }
    if (bannersResult.isSuccess) {
      _slideBannerEntity.addAll(bannersResult.success.listBanner);
    }
    yield HomePageSuccessState(
        homePageModel: HomePageModel(
            productCategories: _productCategories,
            slideBannerEntity: _slideBannerEntity));
  }
}
