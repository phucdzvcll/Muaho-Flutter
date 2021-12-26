import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:muaho/common/common.dart';

part 'cart_update_event.dart';
part 'cart_update_state.dart';

class _CartUpdateEvent extends CartUpdateEvent {
  final CartInfo cartInfo;

  _CartUpdateEvent({required this.cartInfo});
}

class CartUpdateBloc extends Bloc<CartUpdateEvent, CartUpdateState> {
  final CartStore cartStore;
  StreamSubscription<CartInfo>? _updateCartStreamSubscription;

  CartUpdateBloc({required this.cartStore}) : super(CartUpdateInitial()) {
    this._updateCartStreamSubscription =
        cartStore.updateCartBroadcastStream?.listen((event) {
      this.add(_CartUpdateEvent(cartInfo: event));
    });
    on<_CartUpdateEvent>((event, emit) {
      emit(CartUpdatedState(cartInfo: event.cartInfo));
    });
  }

  @override
  Future<void> close() {
    this._updateCartStreamSubscription?.cancel();
    return super.close();
  }
}
