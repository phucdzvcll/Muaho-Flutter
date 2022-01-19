part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class TextingEmailEvent extends LoginEvent {
  final String value;

  const TextingEmailEvent({
    required this.value,
  });

  @override
  List<Object?> get props => [value];
}

class TextingPasswordEvent extends LoginEvent {
  final String value;

  const TextingPasswordEvent({
    required this.value,
  });

  @override
  List<Object?> get props => [value];
}

class ChangeObscureTextEvent extends LoginEvent {
  @override
  List<Object?> get props => [];
}

class PressLoginBtnEvent extends LoginEvent {
  @override
  List<Object?> get props => [];
}
