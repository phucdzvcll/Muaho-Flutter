import 'package:bloc/bloc.dart';
import 'package:email_validator/email_validator.dart';
import 'package:equatable/equatable.dart';
import 'package:muaho/domain/domain.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  bool obscureText = true;
  String password = "";
  String passwordConfirm = "";
  String email = "";
  final RegisterEmailUseCase registerEmailUseCase;

  bool emailValid(String email) => EmailValidator.validate(email);

  RegisterBloc({
    required this.registerEmailUseCase,
  }) : super(RegisterInitial()) {
    on<TextingEmailEvent>((event, emit) {
      email = event.email;
      _handleTextingEmailEvent(emit);
    });

    on<TextingPasswordEvent>((event, emit) {
      password = event.password;

      _handleTextingPasswordEvent(emit);
    });

    on<TextingConfirmPasswordEvent>((event, emit) {
      passwordConfirm = event.passwordConfirm;

      _handleConfirmPasswordEvent(emit);
    });

    on<PressSubmitRegisterEvent>((event, emit) async {
      if (email.isEmpty ||
          !emailValid(email) ||
          password.length < 6 ||
          password.isEmpty ||
          passwordConfirm.isEmpty ||
          passwordConfirm.length < 6) {
        if (email.isEmpty || !emailValid(email)) {
          _handleTextingEmailEvent(emit);
          emit(
            RegisterSubmitState(registerSubmit: RegisterSubmit.emailIllegal),
          );
        }
        if (password.length < 6 || password.isEmpty) {
          _handleTextingPasswordEvent(emit);
          emit(
            RegisterSubmitState(registerSubmit: RegisterSubmit.passwordIllegal),
          );
        }
        if (passwordConfirm.isEmpty || passwordConfirm.length < 6) {
          _handleConfirmPasswordEvent(emit);
          emit(
            RegisterSubmitState(
                registerSubmit: RegisterSubmit.confirmPasswordIllegal),
          );
        }
      } else {
        emit(
          RegisterSubmitState(registerSubmit: RegisterSubmit.requestRegister),
        );
        Either<Failure, RegisterEmailEntity> result =
            await registerEmailUseCase.execute(
          RegisterParam(email: email, password: password),
        );
        if (result.isSuccess) {
          emit(
            RegisterSubmitState(registerSubmit: RegisterSubmit.success),
          );
        } else {
          var fail = result.fail;
          if (fail is RegisterFailure) {
            emit(
              RegisterSubmitErrorState(registerError: fail.registerError),
            );
          } else {
            emit(
              RegisterSubmitErrorState(
                  registerError: RegisterError.defaultError),
            );
          }
        }
      }
    });
  }

  void _handleTextingEmailEvent(Emitter<RegisterState> emit) {
    if (email.isEmpty) {
      emit(
        EmailValidatedState(emailValidatedState: EmailValidated.Empty),
      );
    } else if (!emailValid(email)) {
      emit(
        EmailValidatedState(emailValidatedState: EmailValidated.Illegal),
      );
    } else {
      emit(
        EmailValidatedState(emailValidatedState: EmailValidated.Invalid),
      );
    }
  }

  void _handleTextingPasswordEvent(Emitter<RegisterState> emit) {
    if (password.isEmpty) {
      emit(
        PasswordValidatedState(passwordValidated: PasswordValidated.Empty),
      );
    } else if (password.length < 6) {
      emit(
        PasswordValidatedState(passwordValidated: PasswordValidated.Illegal),
      );
    } else {
      emit(
        PasswordValidatedState(passwordValidated: PasswordValidated.Invalid),
      );
    }
  }

  void _handleConfirmPasswordEvent(Emitter<RegisterState> emit) {
    if (passwordConfirm.isEmpty) {
      emit(
        ConfirmPasswordValidatedState(
            confirmPasswordValidated: ConfirmPasswordValidated.Empty),
      );
    } else if (passwordConfirm.length >= 6 && passwordConfirm == password) {
      emit(
        ConfirmPasswordValidatedState(
            confirmPasswordValidated: ConfirmPasswordValidated.Correct),
      );
    } else {
      emit(
        ConfirmPasswordValidatedState(
            confirmPasswordValidated: ConfirmPasswordValidated.Illegal),
      );
    }
  }
}
