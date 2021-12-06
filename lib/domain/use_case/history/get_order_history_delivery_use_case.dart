import 'package:muaho/domain/common/use_case.dart';
import 'package:muaho/domain/domain.dart';
import 'package:muaho/domain/repository/history_page_repository.dart';
import 'package:muaho/main.dart';

class GetOrderHistoryCompleteUseCase
    extends BaseUseCase<EmptyInput, List<OrderHistoryComplete>> {
  HistoryPageRepository _repository = getIt.get();

  @override
  Future<Either<Failure, List<OrderHistoryComplete>>> executeInternal(
      EmptyInput input) async {
    return await _repository.getOrderHistoryComplete();
  }
}
