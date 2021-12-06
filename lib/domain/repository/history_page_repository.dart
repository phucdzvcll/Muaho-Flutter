import '../domain.dart';

abstract class HistoryPageRepository {
  Future<Either<Failure, List<OrderHistoryDelivering>>>
      getOrderHistoryDelivering();
  Future<Either<Failure, List<OrderHistoryComplete>>> getOrderHistoryComplete();
}
