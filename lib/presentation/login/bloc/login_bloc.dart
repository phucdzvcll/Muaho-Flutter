import 'package:bloc/bloc.dart';
import 'package:email_validator/email_validator.dart';
import 'package:equatable/equatable.dart';
import 'package:muaho/domain/domain.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  bool obscureText = true;
  String password = "";
  String email = "";

  bool emailValid(String email) => EmailValidator.validate(email);
  final LoginEmailUseCase loginEmailUseCase;

  LoginBloc({required this.loginEmailUseCase}) : super(LoginInitial()) {
    on<TextingEmailEvent>(
      (event, emit) {
        email = event.value;
        if (event.value.isEmpty) {
          emit(
            ValidatedEmailState(emailValidated: ValidatedState.Empty),
          );
        } else {
          if (emailValid(event.value)) {
            emit(
              ValidatedEmailState(emailValidated: ValidatedState.Invalid),
            );
          } else {
            emit(
              ValidatedEmailState(emailValidated: ValidatedState.Illegal),
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
            validatedState: ValidatedState.Empty, obscureText: obscureText),
      );
    } else if (password.length < 6) {
      emit(
        ValidatedPasswordState(
            validatedState: ValidatedState.Illegal, obscureText: obscureText),
      );
    } else {
      emit(
        ValidatedPasswordState(
            validatedState: ValidatedState.Invalid, obscureText: obscureText),
      );
    }
  }
}
