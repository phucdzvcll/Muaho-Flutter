import 'package:muaho/common/domain/either.dart';
import 'package:muaho/common/domain/failure.dart';
import 'package:muaho/features/home/domain/models/history/order_detail.dart';
import 'package:muaho/features/home/domain/models/history/order_history_complete.dart';
import 'package:muaho/features/home/domain/models/history/order_history_delivering.dart';

abstract class HistoryPageRepository {
  Future<Either<Failure, List<OrderHistoryDelivering>>>
      getOrderHistoryDelivering();

  Future<Either<Failure, List<OrderHistoryComplete>>> getOrderHistoryComplete();

  Future<Either<Failure, OrderDetailEntity>> getOrderDetail(int orderID);
}
