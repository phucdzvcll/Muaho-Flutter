import 'package:dio/dio.dart';
import 'package:muaho/common/common.dart';
import 'package:retrofit/http.dart';
import 'package:muaho/features/create_address/data/response/create_address_body.dart';

part 'create_address_service.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class CreateAddressService {
  factory CreateAddressService(Dio dio) = _CreateAddressService;

  @POST("/user/address")
  Future createAddress(@Body() CreateAddressBody body);
}
