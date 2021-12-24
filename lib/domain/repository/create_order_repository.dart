import 'package:muaho/common/common.dart';

import '../domain.dart';

abstract class CreateOrderRepository {
  Future<Either<Failure, OrderStatusResult>> createOrder(CartStore cartStore);
}
