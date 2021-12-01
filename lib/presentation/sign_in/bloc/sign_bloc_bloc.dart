import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:muaho/domain/domain.dart';
import 'package:muaho/domain/use_case/sign_in/get_jwt_token_use_case.dart';

part 'sign_bloc_event.dart';
part 'sign_bloc_state.dart';

class SignBloc extends Bloc<SignBlocEvent, SignBlocState> {
  SignBloc() : super(SignBlocInitial());

  GetJwtTokenUseCase _useCase = GetIt.instance.get();

  @override
  Stream<SignBlocState> mapEventToState(SignBlocEvent event) async* {
    if (event is GetJwtTokenEvent) {
      yield* _handleRequestListCategories(event.firebaseToken);
    }
  }

  Stream<SignBlocState> _handleRequestListCategories(
      String firebaseToken) async* {
    yield SignBlocLoading();
    Either<Failure, SignInEntity> result =
        await _useCase.execute(SignInParam(firebaseToken: firebaseToken));
    if (result.isSuccess) {
      yield SignBlocSuccess(entity: result.success);
    } else {
      yield SignBlocError();
    }
  }
}
