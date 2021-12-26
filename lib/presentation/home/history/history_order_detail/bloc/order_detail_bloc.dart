import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:muaho/common/common.dart';
import 'package:muaho/domain/domain.dart';
import 'package:muaho/domain/models/history/order_detail.dart';

part 'order_detail_event.dart';
part 'order_detail_state.dart';

class OrderDetailBloc extends Bloc<OrderDetailEvent, OrderDetailState> {
  OrderDetailBloc({required this.getOrderDetailUseCase})
      : super(OrderDetailInitial());

  final GetOrderDetailUseCase getOrderDetailUseCase;

  @override
  Stream<OrderDetailState> mapEventToState(OrderDetailEvent event) async* {
    if (event is GetOrderDetailEvent) {
      yield* _handleRequestEvent(event);
    }
  }

  Stream<OrderDetailState> _handleRequestEvent(
      GetOrderDetailEvent event) async* {
    yield OrderDetailLoading();
    Either<Failure, OrderDetailEntity> result = await getOrderDetailUseCase
        .execute(OrderDetailParam(orderID: event.orderID));
    if (result.isSuccess) {
      yield OrderDetailSuccess(
          orderDetailSuccessModel: OrderDetailSuccessModel(
              entity: result.success,
              cartInfo: getCartOverView(result.success)));
    } else {
      yield OrderDetailError();
    }
  }

  CartInfo getCartOverView(OrderDetailEntity entity) {
    int itemQuantity = 0;
    int unitQuantity = 0;
    double totalPrice = 0.0;

    if (entity.products.isNotEmpty) {
      entity.products.forEach((element) {
        if (element.quantity > 0) {
          itemQuantity += element.quantity;
          unitQuantity += 1;
          totalPrice += element.quantity * element.price;
        }
      });
    }

    return CartInfo(
      totalAmount: totalPrice,
      itemQuantity: itemQuantity,
      unitQuantity: unitQuantity,
    );
  }
}
