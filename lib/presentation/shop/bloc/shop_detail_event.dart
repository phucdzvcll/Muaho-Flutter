part of 'shop_detail_bloc.dart';

@immutable
abstract class ShopDetailEvent {}

class GetShopDetailEvent extends ShopDetailEvent {
  final int shopID;

  GetShopDetailEvent({required this.shopID});
}

class FilterProductEvent extends ShopDetailEvent {
  final int groupID;

  FilterProductEvent({required this.groupID});
}