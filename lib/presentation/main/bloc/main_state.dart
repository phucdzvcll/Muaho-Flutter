part of 'main_bloc.dart';

abstract class MainState extends Equatable {
  const MainState();
}

class SignInScreenState extends MainState {
  @override
  List<Object> get props => [];
}

class MaintainingScreenState extends MainState {
  final int totalMinutes;

  const MaintainingScreenState({
    required this.totalMinutes,
  });

  @override
  List<Object?> get props => [totalMinutes];
}

class HomeScreenState extends MainState {
  @override
  List<Object?> get props => [];
}
