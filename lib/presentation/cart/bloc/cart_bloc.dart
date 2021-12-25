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
    } else if (event is IncreaseProductEvent) {
      yield* _handleIncreaseProductEvent(event);
    } else if (event is ReducedProductEvent) {
      yield* _handleReducedProductEvent(event);
    } else if (event is RemoveProductEvent) {
      yield* _handleRemoveProductEvent(event);
    } else if (event is ReloadEvent) {
      yield CartSuccess(
          cartSuccessResult: CartSuccessResult(
              cartStore: cartStore,
              cartOverViewModel: cartStore.getCartOverView()));
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

  Stream<CartState> _handleIncreaseProductEvent(
      IncreaseProductEvent event) async* {
    cartStore.addToCart(productStore: event.productStore);
    yield CartSuccess(
        cartSuccessResult: CartSuccessResult(
            cartStore: cartStore,
            cartOverViewModel: cartStore.getCartOverView()));
  }

  Stream<CartState> _handleRemoveProductEvent(RemoveProductEvent event) async* {
    cartStore.removeToCart(productID: event.productId);
    yield CartSuccess(
        cartSuccessResult: CartSuccessResult(
            cartStore: cartStore,
            cartOverViewModel: cartStore.getCartOverView()));
  }

  Stream<CartState> _handleReducedProductEvent(
      ReducedProductEvent event) async* {
    if (event.quantity == 1) {
      yield WarningRemoveProduct(productID: event.productID);
    } else {
      cartStore.removeToCart(productID: event.productID);
      yield CartSuccess(
          cartSuccessResult: CartSuccessResult(
              cartStore: cartStore,
              cartOverViewModel: cartStore.getCartOverView()));
    }
  }
}
