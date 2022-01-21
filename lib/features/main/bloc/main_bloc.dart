import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:muaho/common/common.dart';
import 'package:muaho/common/model/mode_store.dart';
import 'package:muaho/features/home/presentation/setting_page/bloc/setting_bloc.dart';

part 'main_event.dart';
part 'main_state.dart';

class _MainEvent extends MainEvent {
  final int totalMinutes;

  @override
  List<Object?> get props => [totalMinutes];

  const _MainEvent({required this.totalMinutes});
}

class MainBloc extends Bloc<MainEvent, MainState> {
  final CurrentMode currentMode;
  final AppEventBus appEventBus;
  bool _isDark = false;
  StreamSubscription<MaintenanceEventBus>? maintenanceListen;
  StreamSubscription<LogoutEvenBusEvent>? logoutListen;

  MainBloc({
    required this.appEventBus,
    required this.currentMode,
  }) : super(SignInScreenState()) {
    maintenanceListen = appEventBus.on<MaintenanceEventBus>().listen((event) {
      this.add(_MainEvent(totalMinutes: event.totalMinutes));
    });

    logoutListen = appEventBus.on<LogoutEvenBusEvent>().listen((event) {
      this.add(GoToSignInScreenEvent());
    });

    on<_MainEvent>((event, emit) {
      emit(MaintainingScreenState(totalMinutes: event.totalMinutes));
    });

    on<GoToHomeScreenEvent>((event, emit) {
      emit(HomeScreenState());
    });
    on<GoToSignInScreenEvent>((event, emit) {
      emit(SignInScreenState());
    });

    on<InitThemeEvent>((event, emit) async {
      bool isDark = await currentMode.getCurrentMode() ?? false;
      _isDark = isDark;
      emit(ChangeThemeState(isDark: isDark));
    });

    on<ChangeThemeEvent>((event, emit) async {
      _isDark = !_isDark;
      currentMode.save(_isDark);
      emit(ChangeThemeState(isDark: _isDark));
    });
  }

  @override
  void onChange(Change<MainState> change) {
    log(change.toString());
    super.onChange(change);
  }

  @override
  Future<void> close() {
    maintenanceListen?.cancel();
    logoutListen?.cancel();
    return super.close();
  }
}
