part of 'home_page_bloc.dart';

@immutable
abstract class HomePageState {}

class HomePageInitial extends HomePageState {}

class HomePageLoading extends HomePageState {}

class HomePageOnClick extends HomePageState {}

class HomePageSuccessState extends HomePageState {
  final HomePageModel homePageModel;
  final bool? cartIsNotEmpty;

  HomePageSuccessState(
      {required this.homePageModel, required this.cartIsNotEmpty});
}
