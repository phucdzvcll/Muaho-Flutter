part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
}

class TextingEmailEvent extends RegisterEvent {
  final String email;

  const TextingEmailEvent({
    required this.email,
  });

  @override
  List<Object?> get props => [email];
}

class TextingPasswordEvent extends RegisterEvent {
  final String password;

  const TextingPasswordEvent({
    required this.password,
  });

  @override
  List<Object?> get props => [password];
}

class TextingConfirmPasswordEvent extends RegisterEvent {
  final String passwordConfirm;

  const TextingConfirmPasswordEvent({
    required this.passwordConfirm,
  });

  @override
  List<Object?> get props => [passwordConfirm];
}

class PressSubmitRegisterEvent extends RegisterEvent {
  @override
  List<Object?> get props => [];
}
