part of 'search_shop_bloc.dart';

@immutable
abstract class SearchShopState extends Equatable {}

class SearchShopInitial extends SearchShopState {
  @override
  List<Object?> get props => [];
}

class SearchShopLoading extends SearchShopState {
  @override
  List<Object?> get props => [];
}

class SearchShopSuccess extends SearchShopState {
  final List<SearchShop> shops;

  SearchShopSuccess({required this.shops});

  @override
  List<Object?> get props => [shops];
}

class SearchShopError extends SearchShopState {
  @override
  List<Object?> get props => [];
}
