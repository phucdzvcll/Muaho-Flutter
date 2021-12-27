part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class IncreaseProductEvent extends CartEvent {
  final ProductEntity productStore;

  IncreaseProductEvent({required this.productStore});
}

class ReducedProductEvent extends CartEvent {
  final int productID;
  final int quantity;

  ReducedProductEvent({required this.productID, required this.quantity});
}

class RemoveProductEvent extends CartEvent {
  final int productId;

  RemoveProductEvent({required this.productId});
}
