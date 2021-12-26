import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:muaho/common/common.dart';
import 'package:muaho/presentation/cart_update_bloc/cart_update_bloc.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc({
    required this.cartUpdateBloc,
  }) : super(CartInitial());

  final CartUpdateBloc cartUpdateBloc;

  @override
  Stream<CartState> mapEventToState(CartEvent event) async* {
    if (event is IncreaseProductEvent) {
      yield* _handleIncreaseProductEvent(event);
    } else if (event is ReducedProductEvent) {
      yield* _handleReducedProductEvent(event);
    } else if (event is RemoveProductEvent) {
      yield* _handleRemoveProductEvent(event);
    }
  }

  Stream<CartState> _handleIncreaseProductEvent(
      IncreaseProductEvent event) async* {
    cartUpdateBloc.cartStore
        .increaseProduct(productId: event.productStore.productId);
  }

  Stream<CartState> _handleRemoveProductEvent(RemoveProductEvent event) async* {
    cartUpdateBloc.cartStore.removeProduct(productID: event.productId);
  }

  Stream<CartState> _handleReducedProductEvent(
      ReducedProductEvent event) async* {
    ReducedResult reducedProduct =
        cartUpdateBloc.cartStore.reducedProduct(productID: event.productID);
    switch (reducedProduct) {
      case ReducedResult.Success:
        //nothing to do here
        break;
      case ReducedResult.WarningRemove:
        yield WarningRemoveProduct(productID: event.productID);
        break;
      case ReducedResult.NotFound:
        // todo Handle this case NotFound.
        break;
    }
  }
}
