import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:muaho/domain/domain.dart';
import 'package:muaho/presentation/home/home_page/model/home_page_model.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc({
    required this.useCaseProductCategories,
    required this.bannerUseCase,
  }) : super(HomePageInitial()) {
    on<HomePageRequestEvent>((event, emit) async {
      await _handleHomePageRequestEvent(emit);
    });

    on<ChangeCart>((event, emit) async {
      HomePageSuccessState homePageSuccessState = HomePageSuccessState(
        homePageModel: HomePageModel(
            productCategories: _productCategories,
            slideBannerEntity: _slideBannerEntity),
      );

      emit(homePageSuccessState);
    });
  }


  final GetListProductCategoriesHomeUseCase useCaseProductCategories;
  final GetListBannerUseCase bannerUseCase;
  List<ProductCategoryHomeEntity> _productCategories = [];
  List<SlideBannerEntity> _slideBannerEntity = [];

  Future _handleHomePageRequestEvent(Emitter<HomePageState> emit) async {
    emit(HomePageLoading());

    Either<Failure, ProductCategoriesHomeResults> productCategoriesResult =
        await useCaseProductCategories.execute(EmptyInput());

    Either<Failure, BannersResult> bannersResult =
        await bannerUseCase.execute(EmptyInput());
    _productCategories.clear();
    _slideBannerEntity.clear();
    if (productCategoriesResult.isSuccess) {
      var endIndex = productCategoriesResult.success.listProductCategory.length;
      _productCategories.addAll(productCategoriesResult
          .success.listProductCategory
          .sublist(0, endIndex > 8 ? 8 : endIndex));
    }
    if (bannersResult.isSuccess) {
      _slideBannerEntity.addAll(bannersResult.success.listBanner);
    }
    HomePageSuccessState homePageSuccessState = HomePageSuccessState(
      homePageModel: HomePageModel(
          productCategories: _productCategories,
          slideBannerEntity: _slideBannerEntity),
    );

    emit(homePageSuccessState);
  }
}
