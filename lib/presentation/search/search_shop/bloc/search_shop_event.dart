part of 'search_shop_bloc.dart';

@immutable
abstract class SearchShopEvent {}

class SearchEvent implements SearchShopEvent {
  final String keyword;

  SearchEvent({required this.keyword});
}
