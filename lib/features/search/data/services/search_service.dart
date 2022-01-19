import 'package:dio/dio.dart';
import 'package:muaho/common/common.dart';
import 'package:muaho/features/search/data/response/hot_search/hot_search_response.dart';
import 'package:muaho/features/search/data/response/search_shop/shop_response_by_category.dart';
import 'package:muaho/features/search/data/response/search_shop/shop_response_by_keyword.dart';
import 'package:retrofit/http.dart';

part 'search_service.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class SearchService {
  factory SearchService(Dio dio) = _SearchService;

  @GET("/getHotSearch")
  Future<HotSearchResponse> getHotSearch();

  @GET("/searchShop")
  Future<List<ShopResponse>> getShop(@Query("keyword") String keyword);

  @GET("/search/category/{categoryID}")
  Future<ShopCategoryResponse> getShopByCategory(
      @Path("categoryID") int categoryID);
}
