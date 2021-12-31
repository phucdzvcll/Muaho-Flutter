part of 'home_page_bloc.dart';

@immutable
abstract class HomePageState extends Equatable {}

class HomePageInitial extends HomePageState {
  @override
  List<Object?> get props => [];
}

class HomePageLoading extends HomePageState {
  @override
  List<Object?> get props => [];
}

class HomePageOnClick extends HomePageState {
  @override
  List<Object?> get props => [];
}

class HomePageSuccessState extends HomePageState {
  final HomePageModel homePageModel;

  HomePageSuccessState({required this.homePageModel});

  @override
  List<Object?> get props => [homePageModel];
}
