part of 'change_display_name_bloc.dart';

abstract class ChangeDisplayNameEvent extends Equatable {
  const ChangeDisplayNameEvent();
}

class ChangeNameEvent extends ChangeDisplayNameEvent {
  final String displayName;

  const ChangeNameEvent({
    required this.displayName,
  });

  @override
  List<Object?> get props => [displayName];
}
