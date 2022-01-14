part of 'sign_bloc_bloc.dart';

@immutable
abstract class SignBlocEvent extends Equatable{}

class GetJwtTokenEvent extends SignBlocEvent {
  @override
  List<Object?> get props => [];
}
