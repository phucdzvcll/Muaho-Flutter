import 'package:muaho/common/common.dart';
import 'package:muaho/common/domain/either.dart';
import 'package:muaho/common/domain/failure.dart';
import 'package:muaho/features/home/data/response/home_page/slide_banner_response.dart';
import 'package:muaho/features/home/data/services/home_page/home_service.dart';
import 'package:muaho/features/home/domain/models/home/product_category_home.dart';
import 'package:muaho/features/home/domain/models/home/slide_banner_entity.dart';
import 'package:muaho/features/home/domain/repo/home_page_repository.dart';
import 'package:muaho/features/home/domain/use_case/home/get_list_banner_use_case.dart';
import 'package:muaho/features/home/domain/use_case/home/get_list_product_categories_home_use_case.dart';

class HomeRepositoryImpl implements HomePageRepository {
  final HomeService homeService;

  HomeRepositoryImpl({required this.homeService});

  @override
  Future<Either<Failure, BannersResult>> getListSlideBanner() async {
    Future<List<SlideBannerResponse>> requestGetSlideBanner =
        homeService.getSlideBanners();
    var result = await handleNetworkResult(requestGetSlideBanner);
    if (result.isSuccess()) {
      List<SlideBannerEntity> slideBanner = [];
      result.response?.forEach((element) {
        var banner = SlideBannerEntity(
          id: element.id.defaultZero(),
          subject: element.subject.defaultEmpty(),
          description: element.description.defaultEmpty(),
          thumbUrl: element.thumbUrl.defaultEmpty(),
          deepLinkUrl: element.deeplink.defaultEmpty(),
        );
        slideBanner.add(banner);
      });
      return SuccessValue(BannersResult(listBanner: slideBanner));
    } else {
      return FailValue(
        ServerError(msg: result.error, errorCode: result.errorCode),
      );
    }
  }

  @override
  Future<Either<Failure, ProductCategoriesHomeResults>>
      getListProductCategoriesHome() async {
    var requestGetSlideBanner = homeService.getProductCategoriesHome();
    var result = await handleNetworkResult(requestGetSlideBanner);
    if (result.isSuccess()) {
      List<ProductCategoryHomeEntity> categories = [];
      result.response?.forEach((element) {
        var category = ProductCategoryHomeEntity(
            id: element.id.defaultZero(),
            thumbUrl: element.thumbUrl.defaultEmpty(),
            name: element.name.defaultEmpty(),
            deepLink: element.deepLink.defaultEmpty());
        categories.add(category);
      });
      return SuccessValue(
          ProductCategoriesHomeResults(listProductCategory: categories));
    } else {
      return FailValue(
        ServerError(msg: result.error, errorCode: result.errorCode),
      );
    }
  }
}
