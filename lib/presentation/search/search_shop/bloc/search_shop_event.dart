part of 'search_shop_bloc.dart';

@immutable
abstract class SearchShopEvent extends Equatable {}

class SearchEvent extends SearchShopEvent {
  final String keyword;

  SearchEvent({required this.keyword});

  @override
  List<Object?> get props => [keyword];
}
