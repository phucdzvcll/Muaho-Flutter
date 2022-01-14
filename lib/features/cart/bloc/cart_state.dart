part of 'cart_bloc.dart';

@immutable
abstract class CartState extends Equatable {}

class CartInitial extends CartState {
  @override
  List<Object?> get props => [];
}

class CartLoading extends CartState {
  @override
  List<Object?> get props => [];
}

class WarningRemoveProduct extends CartState {
  final int productID;

  WarningRemoveProduct({required this.productID});

  @override
  List<Object?> get props => [productID];
}
