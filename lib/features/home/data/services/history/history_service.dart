import 'package:dio/dio.dart';
import 'package:muaho/common/common.dart';
import 'package:muaho/features/home/data/response/history/order_history_complete_response.dart';
import 'package:muaho/features/home/data/response/history/order_history_delivery_response.dart';
import 'package:muaho/features/home/data/response/history/order_history_detail_response.dart';
import 'package:retrofit/http.dart';

part 'history_service.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class HistoryService {
  factory HistoryService(Dio dio) = _HistoryService;

  @GET("/order/history/delivering")
  Future<List<OrderHistoryDeliveringResponse>> getOrderHistoryDelivering();

  @GET("/order/history/complete")
  Future<List<OrderHistoryCompleteResponse>> getOrderHistoryComplete();

  @GET("/order/{orderID}")
  Future<OrderHistoryDetailResponse> getOrderHistoryDetail(
      @Path("orderID") int orderID);
}
