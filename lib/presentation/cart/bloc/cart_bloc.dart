import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:muaho/common/common.dart';
import 'package:muaho/presentation/components/model/cart_over_view_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc({required this.cartStore}) : super(CartInitial());
  CartStore cartStore;

  @override
  Stream<CartState> mapEventToState(CartEvent event) async* {
    if (event is RequestCartEvent) {
      yield* _handleRequestEvent(event);
    } else if (event is EditCartEvent) {
      yield* _handleEditCartEvent(event);
    }
  }

  Stream<CartState> _handleRequestEvent(RequestCartEvent event) async* {
    yield CartLoading();
    if (cartStore.shopId == -1) {
      yield CartEmpty();
    } else {
      yield CartSuccess(
          cartSuccessResult: CartSuccessResult(
              cartStore: cartStore,
              cartOverViewModel: cartStore.getCartOverView()));
    }
  }

  Stream<CartState> _handleEditCartEvent(EditCartEvent event) async* {
    cartStore.editCart(event.productStore);
    yield CartSuccess(
        cartSuccessResult: CartSuccessResult(
            cartStore: cartStore,
            cartOverViewModel: cartStore.getCartOverView()));
  }
}
