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

class DisplayNameValidatedState extends RegisterState {
  final DisplayNameValidated displayNameValidated;

  const DisplayNameValidatedState({
    required this.displayNameValidated,
  });

  @override
  List<Object?> get props => [displayNameValidated];
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

class RequestingCreateAccountState extends RegisterState {
  final int dateTime = DateTime.now().millisecondsSinceEpoch;

  @override
  List<Object?> get props => [dateTime];
}

class CreateAccountSuccess extends RegisterState {
  @override
  List<Object?> get props => [];
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

enum DisplayNameValidated {
  Invalid,
  TooLong,
  Empty,
}
