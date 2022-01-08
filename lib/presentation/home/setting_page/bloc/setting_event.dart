part of 'setting_bloc.dart';

abstract class SettingEvent extends Equatable {
  const SettingEvent();
}

class GetUserInfoEvent extends SettingEvent {
  @override
  List<Object?> get props => [];
}
