import 'package:dio/dio.dart';
import 'package:muaho/common/common.dart';
import 'package:muaho/data/data.dart';
import 'package:muaho/data/response/history/OrderHistoryDeliveryResponse.dart';
import 'package:retrofit/http.dart';

part 'history_service.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class HistoryService {
  factory HistoryService(Dio dio) = _HistoryService;

  @GET("/order/history/delivering")
  Future<List<OrderHistoryDeliveringResponse>> getOrderHistoryDelivering();

  @GET("/order/history/complete")
  Future<List<OrderHistoryCompleteResponse>> getOrderHistoryComplete();
}
