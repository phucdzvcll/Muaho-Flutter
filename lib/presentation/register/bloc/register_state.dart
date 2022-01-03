part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();
}

class RegisterInitial extends RegisterState {
  @override
  List<Object> get props => [];
}

class EmailValidatedState extends RegisterState {
  final EmailValidated emailValidatedState;

  const EmailValidatedState({
    required this.emailValidatedState,
  });

  @override
  List<Object?> get props => [emailValidatedState];
}

class PasswordValidatedState extends RegisterState {
  final PasswordValidated passwordValidated;

  const PasswordValidatedState({
    required this.passwordValidated,
  });

  @override
  List<Object?> get props => [passwordValidated];
}

class ConfirmPasswordValidatedState extends RegisterState {
  final ConfirmPasswordValidated confirmPasswordValidated;

  const ConfirmPasswordValidatedState({
    required this.confirmPasswordValidated,
  });

  @override
  List<Object?> get props => [confirmPasswordValidated];
}

class RegisterSubmitErrorState extends RegisterState {
  final RegisterError registerError;

  const RegisterSubmitErrorState({
    required this.registerError,
  });

  @override
  List<Object?> get props => [registerError];
}

class RegisterSubmitState extends RegisterState {
  final RegisterSubmit registerSubmit;
  final int dateTime = DateTime.now().millisecondsSinceEpoch;

  RegisterSubmitState({
    required this.registerSubmit,
  });

  @override
  List<Object?> get props => [registerSubmit, dateTime];
}

enum RegisterSubmit {
  requestRegister,
  emailIllegal,
  passwordIllegal,
  confirmPasswordIllegal,
  success,
}

enum ConfirmPasswordValidated {
  Correct,
  Illegal,
  Empty,
}

enum PasswordValidated {
  Invalid,
  Illegal,
  Weak,
  Empty,
}

enum EmailValidated {
  Invalid,
  Illegal,
  Empty,
}
