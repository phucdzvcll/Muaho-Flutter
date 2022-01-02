part of 'hot_search_bloc.dart';

@immutable
abstract class HotSearchState extends Equatable {}

class HotSearchLoadingState extends HotSearchState {
  @override
  List<Object?> get props => [];
}

class HotSearchSuccessState extends HotSearchState {
  final HostSearchResult result;

  HotSearchSuccessState({required this.result});

  @override
  List<Object?> get props => [result];
}

class HotSearchErrorState extends HotSearchState {

  HotSearchErrorState();

  @override
  List<Object?> get props => [];
}

class HotSearchInitState extends HotSearchState {
  @override
  List<Object?> get props => [];
}
