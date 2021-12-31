import 'package:dio/dio.dart';
import 'package:muaho/common/common.dart';
import 'package:muaho/data/data.dart';
import 'package:retrofit/http.dart';

part 'address_service.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class AddressService {
  factory AddressService(Dio dio) = _AddressService;

  @GET("/user/address")
  Future<List<AddressInfoResponse>> getListAddressInfo();

  @POST("/user/address")
  Future createAddress(@Body() CreateAddressBody body);
}
