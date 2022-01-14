import 'package:bloc/bloc.dart';
import 'package:email_validator/email_validator.dart';
import 'package:equatable/equatable.dart';
import 'package:muaho/common/even_bus/app_event_bus.dart';
import 'package:muaho/domain/domain.dart';
import 'package:muaho/features/login/bloc/login_bloc.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  bool obscureText = true;
  String password = "";
  String passwordConfirm = "";
  String email = "";
  String displayName = "";
  final RegisterEmailUseCase registerEmailUseCase;
  final AppEventBus appEventBus;
  bool emailValid(String email) => EmailValidator.validate(email);

  RegisterBloc({
    required this.registerEmailUseCase,
    required this.appEventBus,
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

    on<TextingDisplayNameEvent>((event, emit) {
      displayName = event.displayName;

      _handleDisplayNameEvent(emit);
    });

    on<PressSubmitRegisterEvent>((event, emit) async {
      if (email.isEmpty ||
          !emailValid(email) ||
          password.length < 6 ||
          password.isEmpty ||
          passwordConfirm.isEmpty ||
          passwordConfirm.length < 6 ||
          displayName.length > 50 ||
          displayName.isEmpty) {
        if (email.isEmpty || !emailValid(email)) {
          _handleTextingEmailEvent(emit);
        }
        if (password.length < 6 || password.isEmpty) {
          _handleTextingPasswordEvent(emit);
        }
        if (passwordConfirm.isEmpty || passwordConfirm.length < 6) {
          _handleConfirmPasswordEvent(emit);
        }
        if (displayName.length > 50 || displayName.isEmpty) {
          _handleDisplayNameEvent(emit);
        }
      } else {
        emit(
          RequestingCreateAccountState(),
        );
        Either<Failure, RegisterEmailEntity> result =
            await registerEmailUseCase.execute(
          RegisterParam(
              email: email, password: password, displayName: displayName),
        );
        if (result.isSuccess) {
          emit(
            CreateAccountSuccess(),
          );
          appEventBus.fireEvent(LoginSuccessEventBus());
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

  void _handleDisplayNameEvent(Emitter<RegisterState> emit) {
    if (displayName.isEmpty) {
      emit(
        DisplayNameValidatedState(
            displayNameValidated: DisplayNameValidated.Empty),
      );
    } else if (displayName.length > 50) {
      emit(
        DisplayNameValidatedState(
            displayNameValidated: DisplayNameValidated.TooLong),
      );
    } else {
      emit(
        DisplayNameValidatedState(
            displayNameValidated: DisplayNameValidated.Invalid),
      );
    }
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
