import 'package:muaho/domain/common/use_case.dart';
import 'package:muaho/domain/domain.dart';
import 'package:muaho/domain/repository/history_page_repository.dart';

class GetOrderHistoryCompleteUseCase
    extends BaseUseCase<EmptyInput, List<OrderHistoryComplete>> {
  final HistoryPageRepository historyPageRepository;

  GetOrderHistoryCompleteUseCase({required this.historyPageRepository});

  @override
  Future<Either<Failure, List<OrderHistoryComplete>>> executeInternal(
      EmptyInput input) async {
    return await historyPageRepository.getOrderHistoryComplete();
  }
}
