import 'package:muaho/common/domain/either.dart';
import 'package:muaho/common/domain/failure.dart';
import 'package:muaho/common/domain/use_case.dart';
import 'package:muaho/features/payment/domain/models/order_status_result.dart';
import 'package:muaho/features/payment/domain/models/payment_entity.dart';
import 'package:muaho/features/payment/domain/repo/create_order_repository.dart';

class CreateOrderUseCase extends BaseUseCase<PaymentEntity, OrderStatusResult> {
  final CreateOrderRepository createOrderRepository;

  CreateOrderUseCase({required this.createOrderRepository});

  @override
  Future<Either<Failure, OrderStatusResult>> executeInternal(
      PaymentEntity input) async {
    return await createOrderRepository.createOrder(input);
  }
}
