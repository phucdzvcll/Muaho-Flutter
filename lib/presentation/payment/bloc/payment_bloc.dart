import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:muaho/domain/models/payment/payment_entity.dart';
import 'package:muaho/domain/use_case/order/create_order_use_case.dart';
import 'package:muaho/presentation/cart_update_bloc/cart_update_bloc.dart';
import 'package:muaho/presentation/payment/model/payment_info.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc({
    required this.createOrderUseCase,
    required this.cartUpdateBloc,
  }) : super(PaymentInitial());
  final CartUpdateBloc cartUpdateBloc;
  final CreateOrderUseCase createOrderUseCase;

  @override
  Stream<PaymentState> mapEventToState(PaymentEvent event) async* {
    if (event is CreateOrderEvent) {
      yield* _handleCreateOrder(event);
    }
  }

  Stream<PaymentState> _handleCreateOrder(CreateOrderEvent event) async* {
    if (event.paymentEntity.productEntities.isNotEmpty) {
      var result = await createOrderUseCase.execute(event.paymentEntity);
      if (result.isSuccess) {
        cartUpdateBloc.cartStore.createOrderSuccess();
        yield CreateOrderSuccess();
      } else {
        yield CreateOrderFailed();
      }
    }
  }
}
