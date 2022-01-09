part of 'sign_bloc_bloc.dart';

@immutable
abstract class SignBlocState extends Equatable {}

class SignInitial extends SignBlocState {
  @override
  List<Object?> get props => [];
}

class SignLoading extends SignBlocState {
  @override
  List<Object?> get props => [];
}

class SignSuccess extends SignBlocState {
  final SignInEntity entity;

  SignSuccess({required this.entity});

  @override
  List<Object?> get props => [entity];
}

class SignError extends SignBlocState {
  final String errorMss;

  SignError({required this.errorMss});

  @override
  List<Object?> get props => [errorMss];
}

class MaintenanceSate extends SignBlocState {
  final int totalMinutes;

  MaintenanceSate({
    required this.totalMinutes,
  });

  @override
  List<Object?> get props => [totalMinutes];
}
