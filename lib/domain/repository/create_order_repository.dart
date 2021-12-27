import 'package:muaho/domain/models/payment/payment_entity.dart';

import '../domain.dart';

abstract class CreateOrderRepository {
  Future<Either<Failure, OrderStatusResult>> createOrder(
      PaymentEntity paymentEntity);
}
