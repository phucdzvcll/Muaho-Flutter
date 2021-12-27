import 'package:muaho/common/common.dart';
import 'package:muaho/data/data.dart';
import 'package:muaho/data/remote/order/order_service.dart';
import 'package:muaho/domain/domain.dart';
import 'package:muaho/domain/models/payment/payment_entity.dart';

class OrderRepositoryImpl implements CreateOrderRepository {
  final OrderService service;

  OrderRepositoryImpl({required this.service});

  @override
  Future<Either<Failure, OrderStatusResult>> createOrder(
      PaymentEntity paymentEntity) async {
    var createOrder = service.createOrder(OrderBody(
        total: calculatorTotal(paymentEntity.productEntities),
        totalBeforeDiscount: calculatorTotal(paymentEntity.productEntities),
        shopId: paymentEntity.shopID,
        deliveryAddressID: 5,
        userId: 227,
        products: mapOrderProduct(paymentEntity.productEntities),
        voucherDiscount: 0,
        voucherId: null));
    var result = await handleNetworkResult(createOrder);
    if (result.isSuccess()) {
      return SuccessValue(
          OrderStatusResult(status: (result.response?.status).defaultEmpty()));
    } else {
      return FailValue(Failure());
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
        .map((e) => OrderProduct(e.productId, e.productPrice, e.quantity,
            e.quantity * e.productPrice))
        .toList();
  }
}
