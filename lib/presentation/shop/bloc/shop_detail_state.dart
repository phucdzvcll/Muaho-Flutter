part of 'shop_detail_bloc.dart';

@immutable
abstract class ShopDetailState {}

class ShopDetailInitial extends ShopDetailState {}

class ShopDetailLoading extends ShopDetailState {}

class ShopDetailError extends ShopDetailState {}

class ShopDetailSuccess extends ShopDetailState {
  final ShopProductEntity shopProductEntity;

  ShopDetailSuccess({required this.shopProductEntity});
}
