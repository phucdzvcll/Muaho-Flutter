import 'package:dio/dio.dart';
import 'package:muaho/common/common.dart';
import 'package:muaho/data/data.dart';
import 'package:retrofit/http.dart';

part 'search_service.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class SearchService {
  factory SearchService(Dio dio) = _SearchService;

  @GET("/getHotSearch")
  Future<HotSearchResponse> getHotSearch();

  @GET("/searchShop")
  Future<List<ShopResponse>> getShop(@Query("keyword") String keyword);
}
