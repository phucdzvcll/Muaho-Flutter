part of 'sign_bloc_bloc.dart';

@immutable
abstract class SignBlocEvent {}

class GetJwtTokenEvent extends SignBlocEvent {
  final String firebaseToken;

  GetJwtTokenEvent({required this.firebaseToken});
}
