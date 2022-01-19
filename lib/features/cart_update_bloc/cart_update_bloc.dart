import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:muaho/common/common.dart';
import 'package:muaho/features/home/presentation/setting_page/bloc/setting_bloc.dart';

part 'cart_update_event.dart';
part 'cart_update_state.dart';

class _CartUpdateEvent extends CartUpdateEvent {
  final CartInfo cartInfo;

  _CartUpdateEvent({
    required this.cartInfo,
  });

  @override
  List<Object?> get props => [cartInfo];
}

class CartUpdateBloc extends Bloc<CartUpdateEvent, CartUpdateState> {
  final CartStore cartStore;
  final AppEventBus appEventBus;
  StreamSubscription<CartInfo>? _updateCartStreamSubscription;
  StreamSubscription<LogoutEvenBusEvent>? logoutListen;

  CartUpdateBloc({
    required this.cartStore,
    required this.appEventBus,
  }) : super(CartUpdateInitial()) {
    this._updateCartStreamSubscription =
        cartStore.updateCartBroadcastStream?.listen((event) {
      this.add(_CartUpdateEvent(cartInfo: event));
    });

    logoutListen = appEventBus.on<LogoutEvenBusEvent>().listen((event) {
      cartStore.logout();
    });

    on<_CartUpdateEvent>((event, emit) {
      emit(CartUpdatedState(cartInfo: event.cartInfo));
    });
  }

  @override
  Future<void> close() {
    this._updateCartStreamSubscription?.cancel();
    this.logoutListen?.cancel();
    return super.close();
  }
}
