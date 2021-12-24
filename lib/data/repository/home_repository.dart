import 'package:muaho/common/common.dart';
import 'package:muaho/data/data.dart';
import 'package:muaho/domain/domain.dart';
import 'package:muaho/domain/models/home/product_category_home.dart';

class HomeRepositoryImpl implements HomePageRepository {
  final HomeService homeService;

  HomeRepositoryImpl({required this.homeService});

  @override
  Future<Either<Failure, BannersResult>> getListSlideBanner() async {
    var requestGetSlideBanner = homeService.getSlideBanners();
    var result = await handleNetworkResult(requestGetSlideBanner);
    if (result.isSuccess()) {
      List<SlideBannerEntity> slideBanner = [];
      result.response?.forEach((element) {
        var banner = SlideBannerEntity(
            id: element.id.defaultZero(),
            subject: element.subject.defaultEmpty(),
            description: element.description.defaultEmpty(),
            thumbUrl: element.thumbUrl.defaultEmpty());
        slideBanner.add(banner);
      });
      return SuccessValue(BannersResult(listBanner: slideBanner));
    } else {
      return FailValue(Failure());
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
            name: element.name.defaultEmpty());
        categories.add(category);
      });
      return SuccessValue(
          ProductCategoriesHomeResults(listProductCategory: categories));
    } else {
      return FailValue(Failure());
    }
  }
}
