import 'package:muaho/domain/domain.dart';
import 'package:muaho/domain/models/payment/payment_entity.dart';

class CreateOrderUseCase extends BaseUseCase<PaymentEntity, OrderStatusResult> {
  final CreateOrderRepository createOrderRepository;

  CreateOrderUseCase({required this.createOrderRepository});

  @override
  Future<Either<Failure, OrderStatusResult>> executeInternal(
      PaymentEntity input) async {
    return await createOrderRepository.createOrder(input);
  }
}
