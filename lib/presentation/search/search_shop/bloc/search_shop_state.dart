part of 'search_shop_bloc.dart';

@immutable
abstract class SearchShopState {}

class SearchShopInitial extends SearchShopState {}

class SearchShopLoading extends SearchShopState {}

class SearchShopSuccess extends SearchShopState {
  final List<SearchShop> shops;

  SearchShopSuccess({required this.shops});
}

class SearchShopError extends SearchShopState {}
