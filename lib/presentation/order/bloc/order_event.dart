part of 'order_bloc.dart';

@immutable
abstract class OrderEvent extends Equatable {}

class GetShopDetailEvent extends OrderEvent {
  final int shopID;

  GetShopDetailEvent({required this.shopID});

  @override
  List<Object?> get props => [shopID];
}

class FilterProductEvent extends OrderEvent {
  final int groupID;

  FilterProductEvent({required this.groupID});

  @override
  List<Object?> get props => [groupID];
}

class AddToCartEvent extends OrderEvent {
  final ProductEntity productStore;
  final int shopID;

  AddToCartEvent({required this.productStore, required this.shopID});

  @override
  List<Object?> get props => [productStore, shopID];
}

class ReducedProductEvent extends OrderEvent {
  final int productID;
  final int productQuantity;

  ReducedProductEvent({required this.productID, required this.productQuantity});

  @override
  List<Object?> get props => [productID, productQuantity];
}

class RemoveProductEvent extends OrderEvent {
  final int productID;

  RemoveProductEvent({required this.productID});

  @override
  List<Object?> get props => [productID];
}

class ChangeShopEvent extends OrderEvent {
  final ProductEntity productStore;

  ChangeShopEvent({required this.productStore});

  @override
  List<Object?> get props => [productStore];
}
