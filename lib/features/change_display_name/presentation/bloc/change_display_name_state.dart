part of 'change_display_name_bloc.dart';

abstract class ChangeDisplayNameState extends Equatable {
  const ChangeDisplayNameState();
}

class ChangeDisplayNameInitial extends ChangeDisplayNameState {
  @override
  List<Object> get props => [];
}

class ChangeNameState extends ChangeDisplayNameState {
  final DisplayNameState displayNameState;

  const ChangeNameState({
    required this.displayNameState,
  });

  @override
  List<Object?> get props => [displayNameState];
}

enum DisplayNameState {
  Empty,
  Success,
  Failed,
}
