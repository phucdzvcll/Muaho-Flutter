part of 'order_bloc.dart';

@immutable
abstract class OrderEvent {}

class GetShopDetailEvent extends OrderEvent {
  final int shopID;

  GetShopDetailEvent({required this.shopID});
}

class ReloadEvent extends OrderEvent {}

class FilterProductEvent extends OrderEvent {
  final int groupID;

  FilterProductEvent({required this.groupID});
}

class AddToCartEvent extends OrderEvent {
  final ProductStore product;
  final bool isIncrease;

  AddToCartEvent({required this.product, required this.isIncrease});
}

class ChangeShopEvent extends OrderEvent {
  final ProductStore product;

  ChangeShopEvent({required this.product});
}
