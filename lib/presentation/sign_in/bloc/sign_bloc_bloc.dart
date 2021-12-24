import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:muaho/domain/domain.dart';
import 'package:muaho/domain/use_case/sign_in/get_jwt_token_use_case.dart';

part 'sign_bloc_event.dart';
part 'sign_bloc_state.dart';

class SignBloc extends Bloc<SignBlocEvent, SignBlocState> {
  SignBloc({required this.signInUseCase}) : super(SignInitial());

  SignInUseCase signInUseCase;

  @override
  Stream<SignBlocState> mapEventToState(SignBlocEvent event) async* {
    if (event is GetJwtTokenEvent) {
      yield* _handleRequestSignIn();
    }
  }

  Stream<SignBlocState> _handleRequestSignIn() async* {
    yield SignLoading();
    Either<Failure, SignInEntity> result =
        await signInUseCase.execute(EmptyInput());
    if (result.isSuccess) {
      yield SignSuccess(entity: result.success);
    } else {
      yield SignError(errorMss: "error");
    }
  }
}
