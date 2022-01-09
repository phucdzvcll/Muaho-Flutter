part of 'main_bloc.dart';

abstract class MainEvent extends Equatable {
  const MainEvent();
}

class GoToSignInScreenEvent extends MainEvent {
  @override
  List<Object?> get props => [];
}

class GoToHomeScreenEvent extends MainEvent {
  @override
  List<Object?> get props => [];
}
