import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:muaho/common/extensions/number.dart';
import 'package:muaho/domain/domain.dart';
import 'package:muaho/main.dart';
import 'package:muaho/presentation/home/history/model/order_history_delivering_model.dart';

part 'order_history_delivering_event.dart';
part 'order_history_delivering_state.dart';

class OrderHistoryDeliveringBloc
    extends Bloc<OrderHistoryDeliveringEvent, OrderHistoryDeliveringState> {
  GetOrderHistoryCompleteUseCase _useCase = getIt.get();

  OrderHistoryDeliveringBloc() : super(OrderHistoryDeliveringInitial());

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
    await Future.delayed(Duration(milliseconds: 1500));
    Either<Failure, List<OrderHistoryDelivering>> result =
        await _useCase.execute(EmptyInput());
    if (result.isSuccess) {
      yield OrderHistoryDeliveringSuccess(
          orderHistoryDeliveries: result.success
              .map((e) => OrderHistoryDeliveringModel(
                  shopName: e.shopName,
                  subText: "${e.itemCount} Đơn vị",
                  totalPrice: e.total.formatDouble() + " VNĐ"))
              .toList());
    } else {
      yield OrderHistoryDeliveringError();
    }
  }
}
