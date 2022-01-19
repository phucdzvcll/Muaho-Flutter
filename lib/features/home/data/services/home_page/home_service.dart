import 'package:dio/dio.dart';
import 'package:muaho/common/common.dart';
import 'package:muaho/features/home/data/response/home_page/product_categories_response.dart';
import 'package:muaho/features/home/data/response/home_page/slide_banner_response.dart';
import 'package:retrofit/http.dart';

part 'home_service.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class HomeService {
  factory HomeService(Dio dio) = _HomeService;

  @GET("/banners")
  Future<List<SlideBannerResponse>> getSlideBanners();

  @GET("/categories")
  Future<List<ProductCategoryHomeResponse>> getProductCategoriesHome();
}
