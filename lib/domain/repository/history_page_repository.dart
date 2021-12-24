import 'package:muaho/domain/models/history/order_detail.dart';

import '../domain.dart';

abstract class HistoryPageRepository {
  Future<Either<Failure, List<OrderHistoryDelivering>>>
      getOrderHistoryDelivering();

  Future<Either<Failure, List<OrderHistoryComplete>>> getOrderHistoryComplete();

  Future<Either<Failure, OrderDetailEntity>> getOrderDetail(int orderID);
}
