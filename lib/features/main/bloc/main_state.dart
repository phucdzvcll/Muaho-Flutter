part of 'main_bloc.dart';

abstract class MainState extends Equatable {
  const MainState();
}

abstract class MainNavigateState extends MainState {}

class SignInScreenState extends MainNavigateState {
  @override
  List<Object> get props => [];
}

class MaintainingScreenState extends MainNavigateState {
  final int totalMinutes;

  MaintainingScreenState({
    required this.totalMinutes,
  });

  @override
  List<Object?> get props => [totalMinutes];
}

class HomeScreenState extends MainNavigateState {
  @override
  List<Object?> get props => [];
}

class ChangeThemeState extends MainState {
  final bool isDark;

  @override
  List<Object?> get props => [isDark];

  const ChangeThemeState({
    required this.isDark,
  });
}
