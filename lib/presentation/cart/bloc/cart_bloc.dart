import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:muaho/common/common.dart';
import 'package:muaho/main.dart';
import 'package:muaho/presentation/components/model/cart_over_view_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial());
  CartStore cartStore = getIt.get<CartStore>();

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
              cartStore: cartStore, cartOverViewModel: getCartOverView()));
    }
  }

  Stream<CartState> _handleEditCartEvent(EditCartEvent event) async* {
    cartStore.editCart(event.productStore);
    yield CartSuccess(
        cartSuccessResult: CartSuccessResult(
            cartStore: cartStore, cartOverViewModel: getCartOverView()));
  }

  CartOverViewModel getCartOverView() {
    int amount = 0;
    int totalItem = 0;
    double totalPrice = 0.0;

    if (cartStore.productStores.isNotEmpty) {
      cartStore.productStores.forEach((element) {
        if (element.quantity > 0) {
          amount += element.quantity;
          totalItem += 1;
          totalPrice += element.quantity * element.productPrice;
        }
      });
    }

    return CartOverViewModel(
        amount: "$amount đơn vị - $totalItem sản phầm",
        totalPrice: totalPrice.formatDouble() + " VNĐ");
  }
}
