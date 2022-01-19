import 'package:bloc/bloc.dart';
import 'package:email_validator/email_validator.dart';
import 'package:equatable/equatable.dart';
import 'package:muaho/common/common.dart';
import 'package:muaho/common/domain/either.dart';
import 'package:muaho/common/domain/failure.dart';
import 'package:muaho/features/login/domain/models/login_email_entity.dart';
import 'package:muaho/features/login/domain/use_case/login_email_use_case.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginSuccessEventBus extends AppEvent {
  @override
  List<Object?> get props => [];
}

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  bool obscureText = true;
  String password = "";
  String email = "";
  final AppEventBus appEventBus;
  final LoginEmailUseCase loginEmailUseCase;

  bool emailValid(String email) => EmailValidator.validate(email);

  LoginBloc({
    required this.loginEmailUseCase,
    required this.appEventBus,
  }) : super(LoginInitial()) {
    on<TextingEmailEvent>(
      (event, emit) {
        email = event.value;
        if (event.value.isEmpty) {
          emit(
            ValidatedEmailState(emailValidated: EmailValidatedState.Empty),
          );
        } else {
          if (emailValid(event.value)) {
            emit(
              ValidatedEmailState(emailValidated: EmailValidatedState.Invalid),
            );
          } else {
            emit(
              ValidatedEmailState(emailValidated: EmailValidatedState.Illegal),
            );
          }
        }
      },
    );
    on<TextingPasswordEvent>(
      (event, emit) {
        password = event.value;
        _handleValidatePassword(emit);
      },
    );

    on<ChangeObscureTextEvent>((event, emit) {
      obscureText = !obscureText;
      _handleValidatePassword(emit);
    });

    on<PressLoginBtnEvent>((event, emit) async {
      emit(RequestingLoginState());
      if (email.isEmpty || password.isEmpty) {
        emit(
          LoginValidatedState(mess: "Vui lòng nhập đầy đủ email và password"),
        );
      } else if (!emailValid(email)) {
        emit(
          LoginValidatedState(mess: "Email không hợp lệ"),
        );
      } else if (password.length < 6) {
        emit(
          LoginValidatedState(mess: "Password phải có ít nhất 6 kí tự"),
        );
      } else {
        int startTime = DateTime.now().millisecondsSinceEpoch;
        Either<Failure, LoginEmailEntity> result = await loginEmailUseCase
            .execute(LoginParam(email: email, password: password));
        int requestAddressTime =
            DateTime.now().millisecondsSinceEpoch - startTime;
        int duration = 2000;
        var remainingTime = duration - requestAddressTime;
        if (remainingTime > 0) {
          await Future.delayed(Duration(milliseconds: remainingTime));
        }
        if (result.isSuccess) {
          emit(LoginSuccess());
          appEventBus.fireEvent(LoginSuccessEventBus());
        } else {
          var fail = result.fail;
          if (fail is LoginFailure) {
            emit(
              LoginFail(
                errorMss: fail.loginError,
              ),
            );
          } else {
            emit(
              LoginFail(
                errorMss: LoginError.defaultError,
              ),
            );
          }
        }
      }
    });
  }

  void _handleValidatePassword(Emitter<LoginState> emit) {
    if (password.isEmpty) {
      emit(
        ValidatedPasswordState(
            validatedState: PasswordValidatedState.Empty,
            obscureText: obscureText),
      );
    } else if (password.length < 6) {
      emit(
        ValidatedPasswordState(
            validatedState: PasswordValidatedState.Illegal,
            obscureText: obscureText),
      );
    } else {
      emit(
        ValidatedPasswordState(
            validatedState: PasswordValidatedState.Invalid,
            obscureText: obscureText),
      );
    }
  }
}
