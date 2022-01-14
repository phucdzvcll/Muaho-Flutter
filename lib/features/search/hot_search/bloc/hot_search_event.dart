part of 'hot_search_bloc.dart';

@immutable
abstract class HotSearchEvent extends Equatable {}

class HotSearchRequestEvent extends HotSearchEvent {
  @override
  List<Object?> get props => [];
}
