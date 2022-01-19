import 'package:muaho/common/domain/either.dart';
import 'package:muaho/common/domain/failure.dart';
import 'package:muaho/common/domain/use_case.dart';
import 'package:muaho/features/home/domain/models/history/order_history_complete.dart';
import 'package:muaho/features/home/domain/repo/history_page_repository.dart';

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
