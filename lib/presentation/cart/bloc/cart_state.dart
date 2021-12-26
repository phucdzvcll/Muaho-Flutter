part of 'cart_bloc.dart';

@immutable
abstract class CartState {}

class CartInitial extends CartState {}

class CartSuccess extends CartState {
  final CartSuccessResult cartSuccessResult;

  CartSuccess({required this.cartSuccessResult});
}

class CartSuccessResult {
  final CartStore cartStore;
  final CartInfo cartInfo;

  CartSuccessResult({required this.cartStore, required this.cartInfo});
}

class CartEmpty extends CartState {}

class CartLoading extends CartState {}

class WarningRemoveProduct extends CartState {
  final int productID;

  WarningRemoveProduct({required this.productID});
}
