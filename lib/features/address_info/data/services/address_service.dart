import 'package:dio/dio.dart';
import 'package:muaho/common/common.dart';
import 'package:muaho/features/address_info/data/response/address_info_response.dart';
import 'package:retrofit/http.dart';

part 'address_service.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class AddressService {
  factory AddressService(Dio dio) = _AddressService;

  @GET("/user/address")
  Future<List<AddressInfoResponse>> getListAddressInfo();
}
