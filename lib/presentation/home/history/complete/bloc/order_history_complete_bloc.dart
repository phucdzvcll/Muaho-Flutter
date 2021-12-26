import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:muaho/common/extensions/number.dart';
import 'package:muaho/domain/common/either.dart';
import 'package:muaho/domain/domain.dart';
import 'package:muaho/domain/use_case/history/get_order_history_delivery_use_case.dart';
import 'package:muaho/presentation/home/history/models/order_history_complete_model.dart';

part 'order_history_complete_event.dart';
part 'order_history_complete_state.dart';

class OrderHistoryCompleteBloc
    extends Bloc<OrderHistoryCompleteEvent, OrderHistoryCompleteState> {
  OrderHistoryCompleteBloc({required this.getOrderHistoryCompleteUseCase})
      : super(OrderHistoryCompleteInitial());

  final GetOrderHistoryCompleteUseCase getOrderHistoryCompleteUseCase;

  @override
  Stream<OrderHistoryCompleteState> mapEventToState(
      OrderHistoryCompleteEvent event) async* {
    if (event is GetOrderHistoryCompleteEvent) {
      yield* _handleGetOrderComplete(event);
    }
  }

  Stream<OrderHistoryCompleteState> _handleGetOrderComplete(
      GetOrderHistoryCompleteEvent event) async* {
    yield OrderHistoryCompleteLoading();
    Either<Failure, List<OrderHistoryComplete>> result =
        await getOrderHistoryCompleteUseCase.execute(EmptyInput());
    if (result.isSuccess) {
      yield OrderHistoryCompleteSuccess(
          orderHistoryDeliveries: result.success
              .map((e) => OrderHistoryCompleteModel(
                  orderID: e.orderId,
                  shopName: e.shopName,
                  subText: "${e.itemCount} Đơn vị - ${e.status}",
                  totalPrice: e.total.format() + " VNĐ"))
              .toList());
    } else {
      yield OrderHistoryCompleteError();
    }
  }
}
