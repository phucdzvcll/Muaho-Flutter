part of 'hot_search_bloc.dart';

@immutable
abstract class HotSearchState {}

class HotSearchLoadingState extends HotSearchState {}

class HotSearchSuccessState extends HotSearchState {
  final HostSearchResult result;

  HotSearchSuccessState({required this.result});
}

class HotSearchErrorState extends HotSearchState {
  final String mess;

  HotSearchErrorState({required this.mess});
}

class HotSearchInitState extends HotSearchState {}
