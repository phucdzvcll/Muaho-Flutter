import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:muaho/common/common.dart';
import 'package:muaho/common/model/mode_store.dart';
import 'package:muaho/features/change_display_name/presentation/bloc/change_display_name_bloc.dart';
import 'package:muaho/features/login/presentation/bloc/login_bloc.dart';

part 'setting_event.dart';
part 'setting_state.dart';

class LogoutEvenBusEvent extends AppEvent {
  @override
  List<Object?> get props => [];
}

class _ChangeDisplayNameEvent extends SettingEvent {
  final bool isSuccess;

  const _ChangeDisplayNameEvent({
    required this.isSuccess,
  });

  @override
  List<Object?> get props => [isSuccess];
}

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  final UserStore userStore;
  final AppEventBus appEventBus;
  final FirebaseAuth firebaseAuth;
  bool isSignedWithAnonymous = false;
  bool isDark = false;
  final CurrentMode currentMode;
  StreamSubscription<LoginSuccessEventBus>? listenLogin;
  StreamSubscription<ChangeDisplayName>? listenChangeDisplayName;

  SettingBloc({
    required this.userStore,
    required this.appEventBus,
    required this.firebaseAuth,
    required this.currentMode,
  }) : super(SettingInitial()) {
    listenLogin = appEventBus.on<LoginSuccessEventBus>().listen((event) {
      this.add(InitSettingEvent());
    });

    listenChangeDisplayName =
        appEventBus.on<ChangeDisplayName>().listen((event) {
      this.add(_ChangeDisplayNameEvent(isSuccess: event.isSuccess));
    });

    on<_ChangeDisplayNameEvent>((event, emit) async {
      if (event.isSuccess) {
        String useName = (await userStore.getUserName()).defaultEmpty();
        emit(
          UserNameState(
            displayName: useName,
          ),
        );
        emit(ChangeDisplayNameState(changeName: ChangeName.success));
      } else {
        emit(ChangeDisplayNameState(changeName: ChangeName.fail));
      }
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
        emit(
          SignInState(signIn: SignIn.Logout),
        );
      } else {
        //todo emit state to notification not logged in
      }
    });
  }

  Future<void> _handleGetUserInfoEvent(Emitter<SettingState> emit) async {
    isSignedWithAnonymous = (firebaseAuth.currentUser != null) &&
        (firebaseAuth.currentUser?.isAnonymous).defaultFalse();
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
    emit(
      ThemeState(isDark: await currentMode.getCurrentMode() ?? false),
    );
    if (isSignedWithAnonymous) {
      emit(
        SignInState(signIn: SignIn.Login),
      );
    } else {
      emit(
        SignInState(signIn: SignIn.Logout),
      );
    }
  }

  @override
  Future<void> close() {
    listenLogin?.cancel();
    listenChangeDisplayName?.cancel();
    return super.close();
  }
}
