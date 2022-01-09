import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:muaho/common/even_bus/app_event_bus.dart';
import 'package:muaho/common/extensions/network.dart';
import 'package:muaho/domain/domain.dart';

part 'sign_bloc_event.dart';
part 'sign_bloc_state.dart';

class _MaintenanceEvent extends SignBlocEvent {
  final int totalMinutes;

  @override
  List<Object?> get props => [totalMinutes];

  _MaintenanceEvent({
    required this.totalMinutes,
  });
}

class SignBloc extends Bloc<SignBlocEvent, SignBlocState> {
  SignInUseCase signInUseCase;
  StreamSubscription<MaintenanceEvent>? maintenanceListen;
  final AppEventBus eventBus;

  SignBloc({
    required this.signInUseCase,
    required this.eventBus,
  }) : super(SignInitial()) {
    on<GetJwtTokenEvent>((event, emit) async {
      await _handleRequestSignIn(emit);
    });
    on<_MaintenanceEvent>((event, emit) {
      emit(MaintenanceSate(totalMinutes: event.totalMinutes));
    });

    maintenanceListen = eventBus.on<MaintenanceEvent>().listen((event) {
      this.add(_MaintenanceEvent(totalMinutes: event.totalMinutes));
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

  @override
  Future<void> close() {
    maintenanceListen?.cancel();
    return super.close();
  }
}
