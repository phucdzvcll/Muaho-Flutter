import 'package:muaho/common/domain/either.dart';
import 'package:muaho/common/domain/failure.dart';
import 'package:muaho/common/domain/use_case.dart';
import 'package:muaho/features/home/domain/models/history/order_detail.dart';
import 'package:muaho/features/home/domain/repo/history_page_repository.dart';

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
