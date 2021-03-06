import 'package:dio/dio.dart';
import 'package:muaho/common/common.dart';
import 'package:muaho/features/payment/data/response/order_body.dart';
import 'package:muaho/features/payment/data/response/order_status.dart';
import 'package:retrofit/http.dart';

part 'order_service.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class OrderService {
  factory OrderService(Dio dio) = _OrderService;

  @POST("/order/create")
  Future<OrderStatus> createOrder(@Body() OrderBody body);
}
