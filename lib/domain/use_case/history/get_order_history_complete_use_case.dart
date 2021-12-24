import 'package:muaho/domain/common/use_case.dart';
import 'package:muaho/domain/domain.dart';
import 'package:muaho/domain/repository/history_page_repository.dart';

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
