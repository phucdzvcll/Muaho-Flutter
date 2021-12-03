import 'package:dio/dio.dart';
import 'package:muaho/common/common.dart';
import 'package:muaho/data/data.dart';
import 'package:retrofit/http.dart';

part 'shop_service.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class ShopService {
  factory ShopService(Dio dio) = _ShopService;

  @GET("/shop/{shopId}/products")
  Future<ShopProductResponse> getShopProduct(@Path("shopId") int shopId);
}
