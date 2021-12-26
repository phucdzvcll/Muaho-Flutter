part of 'cart_update_bloc.dart';

@immutable
abstract class CartUpdateState {}

class CartUpdateInitial extends CartUpdateState {}

class CartUpdatedState extends CartUpdateState {
  final CartInfo cartInfo;

  CartUpdatedState({required this.cartInfo});
}
