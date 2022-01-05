import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:muaho/common/common.dart';
import 'package:muaho/domain/domain.dart';
import 'package:muaho/presentation/home/home_page/model/home_page_model.dart';
import 'package:muaho/presentation/login/bloc/login_bloc.dart';

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
  StreamSubscription<LoginSuccessEventBus>? listen;

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

    listen = eventBus.on<LoginSuccessEventBus>().listen((event) async {
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
    listen?.cancel();
    return super.close();
  }
}
