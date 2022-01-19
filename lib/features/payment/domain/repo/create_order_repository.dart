import 'package:muaho/common/domain/either.dart';
import 'package:muaho/common/domain/failure.dart';
import 'package:muaho/features/payment/domain/models/order_status_result.dart';
import 'package:muaho/features/payment/domain/models/payment_entity.dart';

abstract class CreateOrderRepository {
  Future<Either<Failure, OrderStatusResult>> createOrder(
      PaymentEntity paymentEntity);
}
