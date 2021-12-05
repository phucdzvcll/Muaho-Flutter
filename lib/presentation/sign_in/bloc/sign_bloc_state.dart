part of 'sign_bloc_bloc.dart';

@immutable
abstract class SignBlocState {}

class SignInitial extends SignBlocState {}

class SignLoading extends SignBlocState {}

class SignSuccess extends SignBlocState {
  final SignInEntity entity;

  SignSuccess({required this.entity});
}

class SignedState extends SignBlocState {}

class SignError extends SignBlocState {
  final String errorMss;

  SignError({required this.errorMss});
}
