import 'package:muaho/domain/common/either.dart';
import 'package:muaho/domain/common/failure.dart';
import 'package:muaho/domain/common/use_case.dart';
import 'package:muaho/domain/domain.dart';
import 'package:muaho/domain/models/history/order_detail.dart';

class GetOrderDetailUseCase
    extends BaseUseCase<OrderDetailParam, OrderDetailEntity> {
  final HistoryPageRepository historyPageRepository;

  GetOrderDetailUseCase({required this.historyPageRepository});

  @override
  Future<Either<Failure, OrderDetailEntity>> executeInternal(
      OrderDetailParam input) async {
    return await historyPageRepository.getOrderDetail(input.orderID);
  }
}

class OrderDetailParam {
  final int orderID;

  OrderDetailParam({required this.orderID});
}
