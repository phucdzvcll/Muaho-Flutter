import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:muaho/common/common.dart';

part 'cart_update_event.dart';
part 'cart_update_state.dart';

class CartUpdateBloc extends Bloc<CartUpdateEvent, CartUpdateState> {
  CartUpdateBloc() : super(CartUpdateInitial()) {
    on<UpdateCartEvent>((event, emit) {
      emit(CartUpdatedState(cartInfo: event.cartInfo));
    });
  }
}
