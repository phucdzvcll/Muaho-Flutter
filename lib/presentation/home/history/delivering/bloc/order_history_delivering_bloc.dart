import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:muaho/common/extensions/number.dart';
import 'package:muaho/domain/domain.dart';
import 'package:muaho/presentation/home/history/models/order_history_delivering_model.dart';

part 'order_history_delivering_event.dart';
part 'order_history_delivering_state.dart';

class OrderHistoryDeliveringBloc
    extends Bloc<OrderHistoryDeliveringEvent, OrderHistoryDeliveringState> {
  final GetOrderHistoryDeliveryUseCase getOrderHistoryDeliveryUseCase;

  OrderHistoryDeliveringBloc({required this.getOrderHistoryDeliveryUseCase})
      : super(OrderHistoryDeliveringInitial());

  @override
  Stream<OrderHistoryDeliveringState> mapEventToState(
      OrderHistoryDeliveringEvent event) async* {
    if (event is GetOrderHistoryDeliveringEvent) {
      yield* _handleGetOrderDelivering(event);
    }
  }

  Stream<OrderHistoryDeliveringState> _handleGetOrderDelivering(
      GetOrderHistoryDeliveringEvent event) async* {
    yield OrderHistoryDeliveringLoading();
    Either<Failure, List<OrderHistoryDelivering>> result =
        await getOrderHistoryDeliveryUseCase.execute(EmptyInput());
    if (result.isSuccess) {
      yield OrderHistoryDeliveringSuccess(
          orderHistoryDeliveries: result.success
              .map((e) => OrderHistoryDeliveringModel(
                  orderID: e.orderId,
                  shopName: e.shopName,
                  subText: "${e.itemCount} Đơn vị - ${e.status}",
                  totalPrice: e.total.format() + " VNĐ"))
              .toList());
    } else {
      yield OrderHistoryDeliveringError();
    }
  }
}
