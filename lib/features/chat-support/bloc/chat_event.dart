part of 'chat_bloc.dart';

@immutable
abstract class ChatEvent extends Equatable {}

class InitEvent extends ChatEvent {
  @override
  List<Object?> get props => [];
}

class OpenTicketEvent extends ChatEvent {
  final String displayName;

  OpenTicketEvent({required this.displayName});

  @override
  List<Object?> get props => [displayName];
}

class CloseTicketEvent extends ChatEvent {
  @override
  List<Object?> get props => [];
}

class SendChatMsgEvent extends ChatEvent {
  final String msg;

  SendChatMsgEvent({required this.msg});

  @override
  List<Object?> get props => [msg];
}
