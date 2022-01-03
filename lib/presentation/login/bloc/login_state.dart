part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class ValidatedEmailState implements LoginState {
  final EmailValidatedState emailValidated;

  const ValidatedEmailState({
    required this.emailValidated,
  });

  @override
  List<Object?> get props => [emailValidated];

  @override
  bool? get stringify => true;
}

class ValidatedPasswordState implements LoginState {
  final PasswordValidatedState validatedState;
  final bool obscureText;

  const ValidatedPasswordState({
    required this.validatedState,
    required this.obscureText,
  });

  @override
  List<Object?> get props => [validatedState, obscureText];

  @override
  bool? get stringify => true;
}

class LoginSuccess extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoginFail extends LoginState {
  final LoginError errorMss;
  final int dateTime = DateTime.now().millisecondsSinceEpoch;

  @override
  List<Object?> get props => [errorMss, dateTime];

  LoginFail({
    required this.errorMss,
  });
}

class LoginValidatedState extends LoginState {
  final String mess;

  const LoginValidatedState({
    required this.mess,
  });

  @override
  List<Object?> get props => [mess];
}

class RequestingLoginState extends LoginState {
  @override
  List<Object?> get props => [];
}

enum PasswordValidatedState {
  Invalid,
  Illegal,
  Empty,
}

enum EmailValidatedState {
  Invalid,
  Illegal,
  Empty,
}
