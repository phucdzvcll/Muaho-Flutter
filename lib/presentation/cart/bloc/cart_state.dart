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
  final CartOverViewModel cartOverViewModel;

  CartSuccessResult({required this.cartStore, required this.cartOverViewModel});
}

class CartEmpty extends CartState {}

class CartLoading extends CartState {}
