part of 'setting_bloc.dart';

abstract class SettingEvent extends Equatable {
  const SettingEvent();
}

class InitSettingEvent extends SettingEvent {
  @override
  List<Object?> get props => [];
}

class ChangeSettingThemeEvent extends SettingEvent {
  @override
  List<Object?> get props => [];
}

class LogoutEvent extends SettingEvent {
  @override
  List<Object?> get props => [];
}
