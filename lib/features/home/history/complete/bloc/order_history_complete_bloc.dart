import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:muaho/common/extensions/number.dart';
import 'package:muaho/domain/common/either.dart';
import 'package:muaho/domain/domain.dart';
import 'package:muaho/domain/use_case/history/get_order_history_delivery_use_case.dart';
import 'package:muaho/features/home/history/models/order_history_complete_model.dart';

part 'order_history_complete_event.dart';

part 'order_history_complete_state.dart';

class OrderHistoryCompleteBloc
    extends Bloc<OrderHistoryCompleteEvent, OrderHistoryCompleteState> {
  final GetOrderHistoryCompleteUseCase getOrderHistoryCompleteUseCase;

  OrderHistoryCompleteBloc({required this.getOrderHistoryCompleteUseCase})
      : super(OrderHistoryCompleteInitial()) {
    on<GetOrderHistoryCompleteEvent>((event, emit) async {
      await _handleGetOrderComplete(event, emit);
    });
  }

  Future _handleGetOrderComplete(
    GetOrderHistoryCompleteEvent event,
    Emitter<OrderHistoryCompleteState> emit,
  ) async {
    emit(OrderHistoryCompleteLoading());
    Either<Failure, List<OrderHistoryComplete>> result =
        await getOrderHistoryCompleteUseCase.execute(EmptyInput());
    if (result.isSuccess) {
      OrderHistoryCompleteSuccess orderHistoryCompleteSuccess = OrderHistoryCompleteSuccess(
        orderHistoryDeliveries: result.success
            .map(
              (e) => OrderHistoryCompleteModel(
                  orderID: e.orderId,
                  shopName: e.shopName,
                  subText: "${e.itemCount} Đơn vị - ${e.status}",
                  totalPrice: e.total.format() + " VNĐ"),
            )
            .toList(),
      );

      emit(orderHistoryCompleteSuccess);
    } else {
      emit(OrderHistoryCompleteError());
    }
  }
}
