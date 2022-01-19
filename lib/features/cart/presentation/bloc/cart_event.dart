part of 'cart_bloc.dart';

@immutable
abstract class CartEvent extends Equatable {}

class IncreaseProductEvent extends CartEvent {
  final ProductEntity productStore;

  IncreaseProductEvent({required this.productStore});

  @override
  List<Object?> get props => [productStore];
}

class ReducedProductEvent extends CartEvent {
  final int productID;
  final int quantity;

  ReducedProductEvent({required this.productID, required this.quantity});

  @override
  List<Object?> get props => [quantity];
}

class RemoveProductEvent extends CartEvent {
  final int productId;

  RemoveProductEvent({required this.productId});

  @override
  List<Object?> get props => [productId];
}
