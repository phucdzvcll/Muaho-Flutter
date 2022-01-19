part of 'search_shop_bloc.dart';

@immutable
abstract class SearchShopEvent extends Equatable {}

class SearchByKeywordEvent extends SearchShopEvent {
  final String keyword;

  SearchByKeywordEvent({required this.keyword});

  @override
  List<Object?> get props => [keyword];
}

class SearchByCategoryEvent extends SearchShopEvent {
  final int categoryID;

  SearchByCategoryEvent({required this.categoryID});

  @override
  List<Object?> get props => [categoryID];
}
