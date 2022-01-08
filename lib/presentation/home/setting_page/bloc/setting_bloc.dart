import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:muaho/common/common.dart';
import 'package:muaho/presentation/login/bloc/login_bloc.dart';

part 'setting_event.dart';
part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  final UserStore userStore;
  final AppEventBus appEventBus;
  final FirebaseAuth firebaseAuth;
  bool isSigned = false;
  StreamSubscription<AppEvent>? listen;

  SettingBloc({
    required this.userStore,
    required this.appEventBus,
    required this.firebaseAuth,
  }) : super(SettingInitial()) {
    listen = appEventBus.on<LoginSuccessEventBus>().listen((event) {
      this.add(GetUserInfoEvent());
    });

    isSigned = (firebaseAuth.currentUser != null) &&
        (firebaseAuth.currentUser?.isAnonymous).defaultFalse();
    on<GetUserInfoEvent>((event, emit) async {
      await _handleGetUserInfoEvent(emit);
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
  }

  @override
  Future<void> close() {
    listen?.cancel();
    return super.close();
  }
}
