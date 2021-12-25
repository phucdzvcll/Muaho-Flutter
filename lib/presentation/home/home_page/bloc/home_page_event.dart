part of 'home_page_bloc.dart';

@immutable
abstract class HomePageEvent {}

class HomePageRequestEvent extends HomePageEvent {}

class ChangeCart extends HomePageEvent {}
