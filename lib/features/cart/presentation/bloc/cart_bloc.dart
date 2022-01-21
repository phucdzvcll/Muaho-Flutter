import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:muaho/common/common.dart';
import 'package:muaho/features/cart_update_bloc/cart_update_bloc.dart';
import 'package:muaho/features/order/domain/models/shop_product_entity.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartUpdateBloc cartUpdateBloc;

  CartBloc({
    required this.cartUpdateBloc,
  }) : super(CartInitial()) {
    on<IncreaseProductEvent>((event, emit) async {
      await _handleIncreaseProductEvent(event, emit);
    });

    on<ReducedProductEvent>((event, emit) async {
      await _handleReducedProductEvent(event, emit);
    });

    on<RemoveProductEvent>((event, emit) async {
      await _handleRemoveProductEvent(event, emit);
    });
  }

  Future _handleIncreaseProductEvent(
    IncreaseProductEvent event,
    Emitter<CartState> emit,
  ) async {
    cartUpdateBloc.cartStore
        .increaseProduct(productId: event.productStore.productId);
  }

  Future _handleRemoveProductEvent(
    RemoveProductEvent event,
    Emitter<CartState> emit,
  ) async {
    cartUpdateBloc.cartStore.deleteProduct(productID: event.productId);
  }

  Future _handleReducedProductEvent(
    ReducedProductEvent event,
    Emitter<CartState> emit,
  ) async {
    ReducedResult reducedProduct =
        cartUpdateBloc.cartStore.reducedProduct(productID: event.productID);
    switch (reducedProduct) {
      case ReducedResult.Success:
        //nothing to do here
        break;
      case ReducedResult.WarningRemove:
        emit(WarningRemoveProduct(productID: event.productID));
        break;
      case ReducedResult.NotFound:
        // todo Handle this case NotFound.
        break;
    }
  }
}
