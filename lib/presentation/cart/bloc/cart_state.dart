part of 'cart_bloc.dart';

@immutable
abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class WarningRemoveProduct extends CartState {
  final int productID;

  WarningRemoveProduct({required this.productID});
}
