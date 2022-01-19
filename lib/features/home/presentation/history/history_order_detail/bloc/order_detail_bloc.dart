import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:muaho/common/common.dart';
import 'package:muaho/common/domain/either.dart';
import 'package:muaho/common/domain/failure.dart';
import 'package:muaho/features/home/domain/models/history/order_detail.dart';
import 'package:muaho/features/home/domain/use_case/history/get_order_detail_use_case.dart';

part 'order_detail_event.dart';
part 'order_detail_state.dart';

class OrderDetailBloc extends Bloc<OrderDetailEvent, OrderDetailState> {
  OrderDetailBloc({required this.getOrderDetailUseCase})
      : super(OrderDetailInitial()) {
    on<GetOrderDetailEvent>((event, emit) async {
      await _handleRequestEvent(event, emit);
    });
  }

  final GetOrderDetailUseCase getOrderDetailUseCase;

  Future _handleRequestEvent(
      GetOrderDetailEvent event, Emitter<OrderDetailState> emit) async {
    emit(OrderDetailLoading());
    Either<Failure, OrderDetailEntity> result = await getOrderDetailUseCase
        .execute(OrderDetailParam(orderID: event.orderID));
    if (result.isSuccess) {
      emit(OrderDetailSuccess(
        orderDetailSuccessModel: OrderDetailSuccessModel(
          entity: result.success,
          cartInfo: getCartOverView(result.success),
        ),
      ));
    } else {
      emit(OrderDetailError());
    }
  }

  CartSummary getCartOverView(OrderDetailEntity entity) {
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

    return CartSummary(
      totalAmount: totalPrice,
      itemQuantity: itemQuantity,
      unitQuantity: unitQuantity,
    );
  }
}
