import 'package:muaho/domain/common/either.dart';
import 'package:muaho/domain/common/failure.dart';
import 'package:muaho/domain/common/use_case.dart';
import 'package:muaho/domain/domain.dart';
import 'package:muaho/domain/models/history/order_detail.dart';
import 'package:muaho/main.dart';

class GetOrderDetailUseCase
    extends BaseUseCase<OrderDetailParam, OrderDetailEntity> {
  HistoryPageRepository _repository = getIt.get();

  @override
  Future<Either<Failure, OrderDetailEntity>> executeInternal(
      OrderDetailParam input) async {
    return await _repository.getOrderDetail(input.orderID);
  }
}

class OrderDetailParam {
  final int orderID;

  OrderDetailParam({required this.orderID});
}
