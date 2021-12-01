import 'package:dio/dio.dart';
import 'package:muaho/common/common.dart';
import 'package:muaho/data/data.dart';
import 'package:retrofit/http.dart';

part 'home_service.g.dart';

final apiHomeService = HomeService(createDioInstance());

@RestApi(baseUrl: "http://103.221.220.249:9000/api")
abstract class HomeService {
  factory HomeService(Dio dio) = _HomeService;

  @GET("/banners")
  Future<List<SlideBannerResponse>> getSlideBanners();

  @GET("/categories")
  Future<List<ProductCategoryHomeResponse>> getProductCategoriesHome();
}
