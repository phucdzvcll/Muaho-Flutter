import 'package:muaho/common/common.dart';
import 'package:muaho/common/domain/either.dart';
import 'package:muaho/common/domain/failure.dart';
import 'package:muaho/features/home/data/response/history/order_history_detail_response.dart';
import 'package:muaho/features/home/data/services/history/history_service.dart';
import 'package:muaho/features/home/domain/models/history/order_detail.dart';
import 'package:muaho/features/home/domain/models/history/order_history_complete.dart';
import 'package:muaho/features/home/domain/models/history/order_history_delivering.dart';
import 'package:muaho/features/home/domain/repo/history_page_repository.dart';

class HistoryRepositoryImpl implements HistoryPageRepository {
  final HistoryService service;

  HistoryRepositoryImpl({required this.service});

  @override
  Future<Either<Failure, List<OrderHistoryComplete>>>
      getOrderHistoryComplete() async {
    var request = service.getOrderHistoryComplete();
    var result = await handleNetworkResult(request);
    if (result.isSuccess()) {
      List<OrderHistoryComplete> list = [];
      result.response?.forEach((element) {
        list.add(OrderHistoryComplete(
            orderId: element.orderId.defaultZero(),
            orderCode: element.orderCode.defaultEmpty(),
            shopName: element.shopName.defaultEmpty(),
            itemCount: element.itemCount.defaultZero(),
            total: element.total.defaultZero(),
            status: element.status.defaultEmpty(),
            thumbUrl: element.thumbUrl.defaultEmpty()));
      });
      return SuccessValue(list);
    } else {
      return FailValue(
        ServerError(msg: result.error, errorCode: result.errorCode),
      );
    }
  }

  @override
  Future<Either<Failure, List<OrderHistoryDelivering>>>
      getOrderHistoryDelivering() async {
    var request = service.getOrderHistoryDelivering();
    var result = await handleNetworkResult(request);

    if (result.isSuccess()) {
      List<OrderHistoryDelivering> list = [];
      result.response?.forEach((element) {
        list.add(OrderHistoryDelivering(
            orderId: element.orderId.defaultZero(),
            orderCode: element.orderCode.defaultEmpty(),
            shopName: element.shopName.defaultEmpty(),
            itemCount: element.itemCount.defaultZero(),
            total: element.total.defaultZero(),
            //todo parse status to enum
            status: element.status.defaultEmpty(),
            thumbUrl: element.thumbUrl.defaultEmpty()));
      });
      return SuccessValue(list);
    } else {
      return FailValue(
        ServerError(msg: result.error, errorCode: result.errorCode),
      );
    }
  }

  @override
  Future<Either<Failure, OrderDetailEntity>> getOrderDetail(int orderID) async {
    var request = service.getOrderHistoryDetail(orderID);
    NetworkResult<OrderHistoryDetailResponse> result =
        await handleNetworkResult(request);
    if (result.isSuccess()) {
      List<Product> products =
          (result.response?.products).defaultEmpty().map((e) {
        OrderProductDetailResponse response = e;
        return Product(
            productId: response.productId.defaultZero(),
            price: response.price.defaultZero(),
            quantity: response.quantity.defaultZero(),
            total: response.total.defaultZero(),
            productName: (response.productName).defaultEmpty(),
            thumbUrl: (response.productThumbUrl).defaultEmpty());
      }).toList();

      OrderDetailEntity orderDetailEntity = OrderDetailEntity(
          orderId: (result.response?.orderId).defaultZero(),
          voucherCode: (result.response?.voucherCode).defaultEmpty(),
          totalBeforeDiscount:
              (result.response?.totalBeforeDiscount).defaultZero(),
          voucherDiscount: (result.response?.voucherDiscount).defaultZero(),
          total: (result.response?.total).defaultZero(),
          deliveryAddress: (result.response?.deliveryAddress).defaultEmpty(),
          deliveryPhoneNumber:
              (result.response?.deliveryPhoneNumber).defaultEmpty(),
          shopId: (result.response?.shopId).defaultZero(),
          shopName: (result.response?.shopName).defaultEmpty(),
          shopAddress: (result.response?.shopAddress).defaultEmpty(),
          status: (result.response?.status).defaultEmpty(),
          products: products);
      return SuccessValue(orderDetailEntity);
    } else {
      return FailValue(
        ServerError(msg: result.error, errorCode: result.errorCode),
      );
    }
  }
}
