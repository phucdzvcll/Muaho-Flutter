import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:muaho/common/common.dart';
import 'package:muaho/common/domain/either.dart';
import 'package:muaho/common/domain/failure.dart';
import 'package:muaho/features/change_display_name/domain/models/display_name_entity.dart';
import 'package:muaho/features/change_display_name/domain/use_case/change_display_name_use_case.dart';

part 'change_display_name_event.dart';
part 'change_display_name_state.dart';

class ChangeDisplayNameBloc
    extends Bloc<ChangeDisplayNameEvent, ChangeDisplayNameState> {
  final ChangeDisplayNameUseCase changeDisplayNameUseCase;
  final AppEventBus appEventBus;

  ChangeDisplayNameBloc(
      {required this.changeDisplayNameUseCase, required this.appEventBus})
      : super(ChangeDisplayNameInitial()) {
    on<ChangeNameEvent>((event, emit) async {
      if (event.displayName.isEmpty) {
        emit(ChangeNameState(displayNameState: DisplayNameState.Empty));
      } else {
        Either<Failure, DisplayNameEntity> result =
            await changeDisplayNameUseCase.execute(
                ChangeDisplayNameParam(displayName: event.displayName));
        if (result.isSuccess) {
          emit(ChangeNameState(displayNameState: DisplayNameState.Success));
          appEventBus.fireEvent(ChangeDisplayName(isSuccess: true));
        } else {
          emit(ChangeNameState(displayNameState: DisplayNameState.Failed));
          appEventBus.fireEvent(ChangeDisplayName(isSuccess: false));
        }
      }
    });
  }
}

class ChangeDisplayName extends AppEvent {
  final bool isSuccess;

  @override
  List<Object?> get props => [isSuccess];

  ChangeDisplayName({
    required this.isSuccess,
  });
}
