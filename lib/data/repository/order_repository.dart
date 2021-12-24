import 'package:muaho/common/common.dart';
import 'package:muaho/common/model/cart_store.dart';
import 'package:muaho/data/data.dart';
import 'package:muaho/data/remote/order/order_service.dart';
import 'package:muaho/domain/domain.dart';

class OrderRepositoryImpl implements CreateOrderRepository {
  final OrderService service;

  OrderRepositoryImpl({required this.service});

  @override
  Future<Either<Failure, OrderStatusResult>> createOrder(
      CartStore cartStore) async {
    var createOrder = service.createOrder(OrderBody(
        total: calculatorTotal(cartStore),
        totalBeforeDiscount: calculatorTotal(cartStore),
        shopId: cartStore.shopId,
        deliveryAddressID: 5,
        userId: 227,
        products: mapOrderProduct(cartStore),
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

  double calculatorTotal(CartStore cartStore) {
    double total = 0;
    cartStore.productStores.forEach((element) {
      total += element.productPrice * element.quantity;
    });
    return total;
  }

  List<OrderProduct> mapOrderProduct(CartStore cartStore) {
    return cartStore.productStores
        .map((e) => OrderProduct(e.productId, e.productPrice, e.quantity,
            e.quantity * e.productPrice))
        .toList();
  }
}
