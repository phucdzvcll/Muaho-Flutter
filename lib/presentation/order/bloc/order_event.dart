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
  final OrderProduct product;
  final bool isIncrease;

  AddToCartEvent({required this.product, required this.isIncrease});
}
