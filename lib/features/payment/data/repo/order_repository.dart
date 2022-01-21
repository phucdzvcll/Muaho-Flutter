import 'package:muaho/common/common.dart';
import 'package:muaho/common/domain/either.dart';
import 'package:muaho/common/domain/failure.dart';
import 'package:muaho/features/order/domain/models/shop_product_entity.dart';
import 'package:muaho/features/payment/data/response/order_body.dart';
import 'package:muaho/features/payment/data/response/order_status.dart';
import 'package:muaho/features/payment/data/services/order_service.dart';
import 'package:muaho/features/payment/domain/models/order_status_result.dart';
import 'package:muaho/features/payment/domain/models/payment_entity.dart';
import 'package:muaho/features/payment/domain/repo/create_order_repository.dart';

class OrderRepositoryImpl implements CreateOrderRepository {
  final OrderService service;
  OrderRepositoryImpl({
    required this.service,
  });

  @override
  Future<Either<Failure, OrderStatusResult>> createOrder(
      PaymentEntity paymentEntity) async {
    OrderBody orderBody = OrderBody(
        total: calculatorTotal(paymentEntity.productEntities),
        totalBeforeDiscount: calculatorTotal(paymentEntity.productEntities),
        shopId: paymentEntity.shopID,
        deliveryAddressID: paymentEntity.addressID,
        products: mapOrderProduct(paymentEntity.productEntities),
        voucherDiscount: 0,
        voucherId: null);
    var createOrder = service.createOrder(orderBody);
    NetworkResult<OrderStatus> result = await handleNetworkResult(createOrder);
    if (result.isSuccess()) {
      return SuccessValue(OrderStatusResult(
          status: (result.response?.status).defaultEmpty(),
          orderID: (result.response?.orderId).defaultZero()));
    } else {
      return FailValue(
        ServerError(msg: result.error, errorCode: result.errorCode),
      );
    }
  }

  double calculatorTotal(List<ProductEntity> products) {
    double total = 0;
    products.forEach((element) {
      total += element.productPrice * element.quantity;
    });
    return total;
  }

  List<OrderProduct> mapOrderProduct(List<ProductEntity> products) {
    return products
        .map((e) => OrderProduct(
            productId: e.productId,
            price: e.productPrice,
            quantity: e.quantity,
            total: e.quantity * e.productPrice))
        .toList();
  }
}
