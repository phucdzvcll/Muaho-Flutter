part of 'cart_update_bloc.dart';

@immutable
abstract class CartUpdateEvent {}

@immutable
class UpdateCartEvent extends CartUpdateEvent {
  final CartInfo cartInfo;

  UpdateCartEvent({required this.cartInfo});
}
