import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:muaho/common/common.dart';
import 'package:muaho/common/domain/either.dart';
import 'package:muaho/common/domain/failure.dart';
import 'package:muaho/common/domain/use_case.dart';
import 'package:muaho/features/change_display_name/presentation/bloc/change_display_name_bloc.dart';
import 'package:muaho/features/home/domain/models/home/product_category_home.dart';
import 'package:muaho/features/home/domain/models/home/slide_banner_entity.dart';
import 'package:muaho/features/home/domain/use_case/home/get_list_banner_use_case.dart';
import 'package:muaho/features/home/domain/use_case/home/get_list_product_categories_home_use_case.dart';
import 'package:muaho/features/home/presentation/home_page/model/home_page_model.dart';
import 'package:muaho/features/login/presentation/bloc/login_bloc.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class _GetUserNameEvent extends HomePageEvent {
  @override
  List<Object?> get props => [];
}

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final GetListProductCategoriesHomeUseCase useCaseProductCategories;
  final GetListBannerUseCase bannerUseCase;
  List<ProductCategoryHomeEntity> _productCategories = [];
  List<SlideBannerEntity> _slideBannerEntity = [];
  final AppEventBus appEventBus;
  final UserStore userStore;
  final AppEventBus eventBus;
  StreamSubscription<LoginSuccessEventBus>? loginSuccessListen;
  StreamSubscription<ChangeDisplayName>? listenChangeDisplayName;

  HomePageBloc({
    required this.useCaseProductCategories,
    required this.bannerUseCase,
    required this.appEventBus,
    required this.userStore,
    required this.eventBus,
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

    on<_GetUserNameEvent>((event, emit) async {
      var userName = await userStore.getUserName();
      emit(UserNameState(userName: userName.defaultEmpty()));
    });

    loginSuccessListen =
        eventBus.on<LoginSuccessEventBus>().listen((event) async {
      this.add(_GetUserNameEvent());
    });
    listenChangeDisplayName =
        eventBus.on<ChangeDisplayName>().listen((event) async {
      this.add(_GetUserNameEvent());
    });
  }

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
    this.add(_GetUserNameEvent());
  }

  @override
  Future<void> close() {
    loginSuccessListen?.cancel();
    listenChangeDisplayName?.cancel();
    return super.close();
  }
}
