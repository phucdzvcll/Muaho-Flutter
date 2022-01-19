import 'package:dio/dio.dart' as user_service;
import 'package:dio/dio.dart';
import 'package:muaho/common/common.dart';
import 'package:muaho/features/voucher_list/data/response/voucher_list_response.dart';
import 'package:retrofit/http.dart';

part 'user_service.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class UserService {
  factory UserService(user_service.Dio dio) = _UserService;

  @GET("/voucher/list")
  Future<List<VoucherListResponse>> getVoucherList();
}
