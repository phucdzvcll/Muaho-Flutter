import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:muaho/common/extensions/number.dart';
import 'package:muaho/domain/domain.dart';
import 'package:muaho/domain/models/history/order_detail.dart';
import 'package:muaho/main.dart';
import 'package:muaho/presentation/components/model/cart_over_view_model.dart';

part 'order_detail_event.dart';
part 'order_detail_state.dart';

class OrderDetailBloc extends Bloc<OrderDetailEvent, OrderDetailState> {
  OrderDetailBloc() : super(OrderDetailInitial());

  GetOrderDetailUseCase _useCase = getIt.get();

  @override
  Stream<OrderDetailState> mapEventToState(OrderDetailEvent event) async* {
    if (event is GetOrderDetailEvent) {
      yield* _handleRequestEvent(event);
    }
  }

  Stream<OrderDetailState> _handleRequestEvent(
      GetOrderDetailEvent event) async* {
    yield OrderDetailLoading();
    Either<Failure, OrderDetailEntity> result =
        await _useCase.execute(OrderDetailParam(orderID: event.orderID));
    if (result.isSuccess) {
      yield OrderDetailSuccess(
          orderDetailSuccessModel: OrderDetailSuccessModel(
              entity: result.success,
              cartOverViewModel: getCartOverView(result.success)));
    } else {
      yield OrderDetailError();
    }
  }

  CartOverViewModel getCartOverView(OrderDetailEntity entity) {
    int amount = 0;
    int totalItem = 0;
    double totalPrice = 0.0;

    if (entity.products.isNotEmpty) {
      entity.products.forEach((element) {
        if (element.quantity > 0) {
          amount += element.quantity;
          totalItem += 1;
          totalPrice += element.quantity * element.price;
        }
      });
    }

    return CartOverViewModel(
        amount: "$amount đơn vị - $totalItem sản phầm",
        totalPrice: totalPrice.formatDouble() + " VNĐ");
  }
}
