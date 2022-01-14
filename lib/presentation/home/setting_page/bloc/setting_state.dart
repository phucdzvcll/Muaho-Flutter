part of 'setting_bloc.dart';

abstract class SettingState extends Equatable {
  const SettingState();
}

class SettingInitial extends SettingState {
  @override
  List<Object> get props => [];
}

class UserNameState extends SettingState {
  final String displayName;

  const UserNameState({
    required this.displayName,
  });

  @override
  List<Object?> get props => [displayName];
}

class EmailState extends SettingState {
  final String email;

  const EmailState({
    required this.email,
  });

  @override
  List<Object?> get props => [email];
}

class ContactPhoneState extends SettingState {
  final String contactPhone;

  const ContactPhoneState({
    required this.contactPhone,
  });

  @override
  List<Object?> get props => [contactPhone];
}

class ThemeState extends SettingState {
  final bool isDark;

  const ThemeState({
    required this.isDark,
  });

  @override
  List<Object?> get props => [isDark];
}
