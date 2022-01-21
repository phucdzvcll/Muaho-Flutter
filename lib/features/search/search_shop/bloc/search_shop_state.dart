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
  final List<SearchShopByKeywordEntity> shops;

  @override
  List<Object?> get props => [shops];

  SearchShopSuccess({
    required this.shops,
  });
}

class SearchShopByKeywordSuccess extends SearchShopSuccess {
  final List<SearchShopByKeywordEntity> shops;

  SearchShopByKeywordSuccess(this.shops) : super(shops: shops);

  @override
  List<Object?> get props => [shops];
}

class SearchShopByCategorySuccess extends SearchShopSuccess {
  final int id;
  final String category;
  final List<SearchShopByKeywordEntity> shops;

  SearchShopByCategorySuccess(this.shops,
      {required this.category, required this.id})
      : super(shops: shops);

  @override
  List<Object?> get props => [shops, category, id];
}

class SearchShopError extends SearchShopState {
  @override
  List<Object?> get props => [];
}
