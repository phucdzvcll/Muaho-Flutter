import 'package:muaho/common/domain/either.dart';
import 'package:muaho/common/domain/failure.dart';
import 'package:muaho/common/domain/use_case.dart';
import 'package:muaho/features/home/domain/models/history/order_history_delivering.dart';
import 'package:muaho/features/home/domain/repo/history_page_repository.dart';

class GetOrderHistoryDeliveryUseCase
    extends BaseUseCase<EmptyInput, List<OrderHistoryDelivering>> {
  final HistoryPageRepository historyRepository;

  GetOrderHistoryDeliveryUseCase({required this.historyRepository});

  @override
  Future<Either<Failure, List<OrderHistoryDelivering>>> executeInternal(
      EmptyInput input) async {
    return await historyRepository.getOrderHistoryDelivering();
  }
}
