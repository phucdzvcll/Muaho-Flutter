import 'package:muaho/domain/common/use_case.dart';
import 'package:muaho/domain/domain.dart';
import 'package:muaho/domain/repository/history_page_repository.dart';
import 'package:muaho/main.dart';

class GetOrderHistoryCompleteUseCase
    extends BaseUseCase<EmptyInput, List<OrderHistoryDelivering>> {
  HistoryPageRepository _repository = getIt.get();

  @override
  Future<Either<Failure, List<OrderHistoryDelivering>>> executeInternal(
      EmptyInput input) async {
    return await _repository.getOrderHistoryDelivering();
  }
}
