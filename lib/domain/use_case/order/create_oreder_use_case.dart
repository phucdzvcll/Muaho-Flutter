import 'package:muaho/common/common.dart';
import 'package:muaho/domain/common/either.dart';
import 'package:muaho/domain/common/use_case.dart';
import 'package:muaho/domain/domain.dart';
import 'package:muaho/main.dart';

class CreateOrderUseCase extends BaseUseCase<CartStore, OrderStatusResult> {
  CreateOrderRepository _repository = getIt.get<CreateOrderRepository>();

  @override
  Future<Either<Failure, OrderStatusResult>> executeInternal(
      CartStore input) async {
    return await _repository.createOrder(input);
  }
}
