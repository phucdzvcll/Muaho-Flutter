part of 'order_bloc.dart';

@immutable
abstract class OrderEvent {}

class GetShopDetailEvent extends OrderEvent {
  final int shopID;

  GetShopDetailEvent({required this.shopID});
}

class FilterProductEvent extends OrderEvent {
  final int groupID;

  FilterProductEvent({required this.groupID});
}

class AddToCartEvent extends OrderEvent {
  final ProductStore productStore;
  final int shopID;

  AddToCartEvent({required this.productStore, required this.shopID});
}

class ReducedProductEvent extends OrderEvent {
  final int productID;
  final int productQuantity;

  ReducedProductEvent({required this.productID, required this.productQuantity});
}

class RemoveProductEvent extends OrderEvent {
  final int productID;

  RemoveProductEvent({required this.productID});
}

class ReloadEvent extends OrderEvent {}

class ChangeShopEvent extends OrderEvent {
  final ProductStore productStore;

  ChangeShopEvent({required this.productStore});
}
