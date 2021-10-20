import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:muaho/data/data.dart';

part 'home_service.g.dart';
@RestApi(baseUrl: "https://virtserver.swaggerhub.com/TinyAppsTeam/Muaho/1.0.0/")
abstract class HomeService {
  factory HomeService(Dio dio) = _HomeService;

  @GET("/banners")
  Future<List<Data>> getSlideBanners();


  //gen lai dang nay xem con
//con de kieu du lieu sai ma
}
