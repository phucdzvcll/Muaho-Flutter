import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:muaho/common/domain/either.dart';
import 'package:muaho/common/domain/failure.dart';
import 'package:muaho/common/domain/use_case.dart';
import 'package:muaho/features/sign_in/domain/models/sign_in_model.dart';
import 'package:muaho/features/sign_in/domain/use_case/get_jwt_token_use_case.dart';

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

    on<ReloadEvent>((event, emit) {
      this.add(GetJwtTokenEvent());
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
