import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:muaho/domain/domain.dart';

part 'sign_bloc_event.dart';
part 'sign_bloc_state.dart';

class SignBloc extends Bloc<SignBlocEvent, SignBlocState> {
  SignInUseCase signInUseCase;

  SignBloc({
    required this.signInUseCase,
  }) : super(SignInitial()) {
    on<GetJwtTokenEvent>((event, emit) async {
      await _handleRequestSignIn(emit);
    });
  }

  Future _handleRequestSignIn(Emitter<SignBlocState> emit) async {
    emit(SignLoading());
    Either<Failure, SignInEntity> result =
        await signInUseCase.execute(EmptyInput());
    if (result.isSuccess) {
      emit(SignSuccess(entity: result.success));
    } else {
      //todo handle error in UI
      emit(SignError(errorMss: "error"));
    }
  }
}
