import 'package:muaho/common/common.dart';
import 'package:muaho/domain/common/either.dart';
import 'package:muaho/domain/common/use_case.dart';
import 'package:muaho/domain/domain.dart';

class CreateOrderUseCase extends BaseUseCase<CartStore, OrderStatusResult> {
  final CreateOrderRepository createOrderRepository;

  CreateOrderUseCase({required this.createOrderRepository});

  @override
  Future<Either<Failure, OrderStatusResult>> executeInternal(
      CartStore input) async {
    return await createOrderRepository.createOrder(input);
  }
}
