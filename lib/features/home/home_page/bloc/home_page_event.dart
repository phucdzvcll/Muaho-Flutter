part of 'home_page_bloc.dart';

@immutable
abstract class HomePageEvent extends Equatable {}

class HomePageRequestEvent extends HomePageEvent {
  @override
  List<Object?> get props => [];
}

class ChangeCart extends HomePageEvent {
  @override
  List<Object?> get props => [];
}
