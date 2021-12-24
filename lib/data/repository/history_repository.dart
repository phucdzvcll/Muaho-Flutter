import 'package:muaho/common/common.dart';
import 'package:muaho/data/data.dart';
import 'package:muaho/domain/domain.dart';
import 'package:muaho/domain/models/history/order_detail.dart';

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
      return FailValue(Failure());
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
            status: element.status.defaultEmpty(),
            thumbUrl: element.thumbUrl.defaultEmpty()));
      });
      return SuccessValue(list);
    } else {
      return FailValue(Failure());
    }
  }

  @override
  Future<Either<Failure, OrderDetailEntity>> getOrderDetail(int orderID) async {
    var request = service.getOrderHistoryDetail(orderID);
    var result = await handleNetworkResult(request);
    if (result.isSuccess()) {
      List<Product> products =
          (result.response?.products).defaultEmpty().map((e) {
        ProductDetailResponse response = e as ProductDetailResponse;
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
      return FailValue(Failure());
    }
  }
}
