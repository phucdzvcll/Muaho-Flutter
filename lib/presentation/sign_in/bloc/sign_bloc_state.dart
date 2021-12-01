part of 'sign_bloc_bloc.dart';

@immutable
abstract class SignBlocState {}

class SignBlocInitial extends SignBlocState {}

class SignBlocLoading extends SignBlocState {}

class SignBlocSuccess extends SignBlocState {
  final SignInEntity entity;

  SignBlocSuccess({required this.entity});
}

class SignBlocError extends SignBlocState {}
