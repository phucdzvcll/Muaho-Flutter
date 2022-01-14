import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:muaho/common/common.dart';
import 'package:muaho/common/model/mode_store.dart';
import 'package:muaho/features/login/bloc/login_bloc.dart';

part 'setting_event.dart';
part 'setting_state.dart';

class LogoutEvenBusEvent extends AppEvent {
  @override
  List<Object?> get props => [];
}

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  final UserStore userStore;
  final AppEventBus appEventBus;
  final FirebaseAuth firebaseAuth;
  bool isSignedWithAnonymous = false;
  bool isDark = false;
  final CurrentMode currentMode;
  StreamSubscription<AppEvent>? listen;

  SettingBloc({
    required this.userStore,
    required this.appEventBus,
    required this.firebaseAuth,
    required this.currentMode,
  }) : super(SettingInitial()) {
    listen = appEventBus.on<LoginSuccessEventBus>().listen((event) {
      this.add(InitSettingEvent());
    });

    on<InitSettingEvent>((event, emit) async {
      await _handleGetUserInfoEvent(emit);
    });

    on<ChangeSettingThemeEvent>((event, emit) async {
      emit(ThemeState(isDark: await currentMode.getCurrentMode() ?? false));
    });

    on<LogoutEvent>((event, emit) async {
      isSignedWithAnonymous = (firebaseAuth.currentUser != null) &&
          (firebaseAuth.currentUser?.isAnonymous).defaultFalse();
      if (!isSignedWithAnonymous) {
        await firebaseAuth.signOut();
        appEventBus.fireEvent(LogoutEvenBusEvent());
      } else {
        //todo emit state to notification not logged in
      }
    });
  }

  Future<void> _handleGetUserInfoEvent(Emitter<SettingState> emit) async {
    emit(
      UserNameState(
        displayName: (await userStore.getUserName()).defaultEmpty(),
      ),
    );
    emit(
      EmailState(
        email: (await userStore.getEmail()).defaultEmpty(),
      ),
    );
    emit(
      ContactPhoneState(
        contactPhone: (await userStore.getContactPhone()).defaultEmpty(),
      ),
    );
    emit(ThemeState(isDark: await currentMode.getCurrentMode() ?? false));
  }

  @override
  Future<void> close() {
    listen?.cancel();
    return super.close();
  }
}
